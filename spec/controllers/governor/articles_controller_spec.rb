require 'spec_helper'

module Governor
  describe ArticlesController do
    include Devise::TestHelpers
    render_views
    
    before(:each) do
      @user = Factory(:user)
      @article = Factory(:article, :author => @user)
      @comments = [Factory(:comment, :resource => @article, :commenter => @user),
                   Factory(:comment, :resource => @article, :commenter => @user),
                   Factory(:comment, :resource => @article, :commenter => @user)]
    end
    
    it "loads GovernorCommentsHelper" do
      get :show, :governor_mapping => :articles, :id => @article.id
      response.body.should =~ /3 comments/
    end
    
    context "comments management" do
      it "renders the form" do
        get :edit_comments, :governor_mapping => :articles
        response.body.should =~ /Comments Management/
      end
      
      it "marks 2 comments as spam" do
        post :update_comments, :governor_mapping => :articles, :bulk_operation => 'mark_spam',
             :comments => {@comments[0].id.to_s => '1', @comments[2].id.to_s => '1'}
        Comment.count.should == 3
        Comment.hidden.count.should == 2
      end
      
      it "unmarks all comments as spam" do
        Comment.update_all(:hidden => true)
        post :update_comments, :governor_mapping => :articles, :bulk_operation => 'not_spam',
             :comments => {@comments[0].id.to_s => '1', @comments[1].id.to_s => '1', @comments[2].id.to_s => '1'}
        Comment.public.count.should == 3
      end
      
      it "deletes all comments" do
        post :update_comments, :governor_mapping => :articles, :bulk_operation => 'destroy',
             :comments => {@comments[0].id.to_s => '1', @comments[1].id.to_s => '1', @comments[2].id.to_s => '1'}
        Comment.count.should == 0
      end
    end
  end
end