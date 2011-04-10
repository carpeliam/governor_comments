require 'spec_helper'

class ActionView::Base
  include Governor::Controllers::Helpers
  
  def params
    {:governor_mapping => :articles}
  end
end

module Governor
  describe "governor/articles/show.html.erb" do
    include Devise::TestHelpers
    
    before(:each) do
      @user = Factory(:user)
      @article = Factory(:article, :author => @user)
      @comment = Factory(:comment, :article => @article, :commenter => @user)
      assign(:article, @article)
      assign(:comment, @comment)
    end
    
    it "shows the comments" do
      sign_in @user
      render

      rendered.should =~ /add a comment/
    end
  end
end