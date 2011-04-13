require 'governor_comments/comment'
require 'governor_comments/rails'

comments = Governor::Plugin.new('comments')
comments.add_migration(File.join(File.dirname(__FILE__), 'templates', 'create_comments.rb'))
comments.set_routes do
  resources :comments, :module => :governor do
    member do
      put 'mark_spam', 'not_spam'
    end
  end
end
comments.register_model_callback do |base|
  base.has_many :comments, :dependent => :destroy
end
comments.add_helper "GovernorCommentsHelper"
comments.register_partial :after_article_whole, 'articles/comments'
comments.register_partial :after_article_description, 'articles/comment_link'

Governor::PluginManager.register comments