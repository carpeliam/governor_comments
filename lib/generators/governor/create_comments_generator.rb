require 'rails/generators'
require 'rails/generators/migration'
module Governor
  class CreateCommentsGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    source_root File.expand_path('../templates', __FILE__)
    argument :resource, :type => :string, :default => Governor.default_resource.plural.to_s
    class_option :polymorphic, :type => :boolean, :default => false, :desc => 'Set to true if you want to associate comments with multiple object types. False by default.'
    desc 'Adds Comment and Guest models and accompanying migrations to your application.'
  
    def self.next_migration_number(dirname)
      if ActiveRecord::Base.timestamped_migrations
        Time.new.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end
    
    def create_models
      template 'models/comment.rb', "app/models/comment.rb"
      template 'models/guest.rb', "app/models/guest.rb"
    end
  
    def create_migration_file
      migration_template 'migrations/create_comments.rb', "db/migrate/governor_create_comments.rb", :skip => true
    end
    
    private
    def mapping
      Governor.resources[resource.pluralize.to_sym]
    end
  end
end