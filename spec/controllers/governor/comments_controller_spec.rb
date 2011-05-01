require 'spec_helper'

module Governor
  describe CommentsController do
    include Devise::TestHelpers
    
    before(:each) do
      @user = Factory(:user)
      @article = Factory(:article, :author => @user)
      @comment = Factory(:comment, :resource => @article, :commenter => @user)
      sign_in @user
    end
    
    context "#create" do
      it "creates a new comment" do
        post :create, :governor_mapping => :articles, :article_id => @article.id, :comment => {:content => "$$$"}
        assigns[:comment].should_not be_a_new_record
        assigns[:comment].commenter.should == @user
        assigns[:article].should == @article
      end
    end
    
    context "#mark_spam" do
      it "hides the comment" do
        put :mark_spam, :governor_mapping => :articles, :article_id => @article.id, :id => @comment.id
        assigns[:comment].should be_hidden
      end
    end
    
    context "#not_spam" do
      before(:each) { @comment.update_attribute(:hidden, true) }
      it "unhides the comment" do
        put :not_spam, :governor_mapping => :articles, :article_id => @article.id, :id => @comment.id
        assigns[:comment].should_not be_hidden
      end
    end
  end
end