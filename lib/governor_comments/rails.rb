module GovernorComments
  class Engine < ::Rails::Engine
    config.to_prepare do
      ActionController::Base.helper GovernorCommentsHelper
    end
  end
end