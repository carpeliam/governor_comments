require 'spec_helper'

module Governor
  describe ArticlesController do
    include Devise::TestHelpers
    render_views
    
    before(:each) do
      @user = Factory(:user)
      @article = Factory(:article, :author => @user)
      @comment = Factory(:comment, :resource => @article, :commenter => @user)
    end
    
    it "loads GovernorCommentsHelper" do
      get :show, :governor_mapping => :articles, :id => @article.id
      response.body.should =~ /1 comment/
    end
  end
end