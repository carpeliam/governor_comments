module GovernorComments
  module Controllers
    module Methods
      def edit_comments
        @comments = ::Comment.all(:include => [:resource, :commenter])
      end
      def update_comments
        action = params[:bulk_operation]
        ids = params[:comments].try(:keys) || []
        result = true
        ::Comment.all(:conditions => {:id => ids}).each do |comment|
          result &= comment.send(action)
        end
        redirect_to mapping.plural
      end
    end
  end
end