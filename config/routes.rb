Rails.application.routes.draw do
  scope 'governor', :module => 'governor' do
    resources :comments, :only => :index
  end
end
