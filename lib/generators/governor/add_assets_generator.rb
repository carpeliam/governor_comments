require 'rails/generators'
module Governor
  class AddAssetsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc 'Installs assets into your public directory.'
    
    def install_javascripts
      copy_file 'assets/javascripts/governor-comments.js', 'public/javascripts/governor-comments.js'
    end
  
    def install_stylesheets
      copy_file 'assets/stylesheets/governor-comments.css', 'public/stylesheets/governor-comments.css'
    end
  end
end