module Governor
  module Controllers
    module Methods
      def edit_comments
        # TODO support polymorphic properly
        @comments = Comment.all
      end
    end
  end
end