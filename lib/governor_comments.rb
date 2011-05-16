require 'governor_comments/controllers/methods'
require 'governor_comments/comment'
require 'governor_comments/rails'

comments = Governor::Plugin.new('comments')
comments.add_migration(File.join(File.dirname(__FILE__), 'templates', 'create_comments.rb'))
comments.set_routes do
  collection do
    get 'edit_comments'
    put 'update_comments'
  end
  resources :comments, :module => :governor do
    member do
      post 'mark_spam', 'not_spam'
    end
  end
end
comments.register_controller_callback do |controller|
  controller.send :include, GovernorComments::Controllers::Methods
end
comments.register_model_callback do |base|
  association = Comment.reflect_on_association(:resource)
  comment_args = (association.options[:polymorphic]) ? {:as => 'resource'} : {:foreign_key => 'resource_id'}
  base.has_many :comments, comment_args.merge(:dependent => :destroy)
end
comments.register_partial :after_article_whole, 'articles/comments'
comments.register_partial :after_article_description, 'articles/comment_link'
comments.add_to_navigation do |resource|
  concat(link_to(t('governor_comments.manage_comments'), polymorphic_path(resource, :action => :edit_comments)))
end

Governor::PluginManager.register comments