require 'spec_helper'

class ActionView::Base
  include Governor::Controllers::Helpers
  include GovernorCommentsHelper
  
  def params
    {:governor_mapping => :articles}
  end
  
  def action_name
    'new'
  end
end

module Governor
  describe "governor/articles/show.html.erb" do
    include Devise::TestHelpers
    
    before(:each) do
      @user = Factory(:user)
      @article = Factory(:article, :author => @user)
      @comment = Factory(:comment, :resource => @article, :commenter => @user)
      assign(:article, @article)
      assign(:comment, @comment)
    end
    
    
    it "shows the comments" do
      sign_in @user
      render

      rendered.should =~ /1 comment/
      rendered.should =~ /add a comment/
    end
  end
end