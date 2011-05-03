module Governor
  class CommentsController < ApplicationController
    include Governor::Controllers::Helpers
    
    before_filter :init_resource
    before_filter :authorize_commenter!, :except => [:new, :create]
    before_filter :get_comment, :only => [:edit, :update, :destroy, :mark_spam, :not_spam]
    
    helper :governor
    helper Governor::Controllers::Helpers
    
    def create
      params[:comment][:commenter] = governor_logged_in? ? the_governor : Guest.new(params[:commenter])
    
      @comment = resource.comments.new(params[:comment])
    
      respond_to do |format|
        if @comment.save
          @comment.update_attribute(:hidden, true) if @comment.respond_to?(:spam) and @comment.spam?
          flash[:notice] = 'Your comment was successfully added.'
          format.html { redirect_to resource }
          format.xml  { render :xml => @comment, :status => :created, :location => @comment }
        else
          flash[:error] = 'There was a problem with your submission.'
          format.html { render :action => "new" }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end
    end
  
    def edit
    end
  
    def update
      respond_to do |format|
        if @comment.update_attributes(params[:comment])
          flash[:notice] = 'Comment was successfully updated.'
          format.html { redirect_to resource }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @comment.destroy
    
      flash[:notice] = 'Comment successfully deleted.'

      respond_to do |format|
        format.html { redirect_to resource }
        format.xml  { head :ok }
      end
    end
  
    def mark_spam
      @comment.mark_spam
      redirect_to resource
    end
  
    def not_spam
      @comment.not_spam
      redirect_to resource
    end
    
    def get_comment
      @comment = resource.comments.find(params[:id])
    end
    
    private
    def authorize_commenter!
      if %(edit update destroy).include? action_name
        authorize_governor!
      else
        redirect_to root_path unless governor_authorized?(:edit, resource)
      end
    end
  end
end