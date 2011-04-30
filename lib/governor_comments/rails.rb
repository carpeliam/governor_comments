require 'governor'
module GovernorComments
  class Engine < ::Rails::Engine
    config.to_prepare do
      Governor::ArticlesController.helper GovernorCommentsHelper
    end
  end
end