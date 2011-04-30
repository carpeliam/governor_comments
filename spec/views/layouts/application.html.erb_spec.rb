require 'spec_helper'

describe "layouts/application.html.erb" do
  include Devise::TestHelpers
  
  before(:each) do
    sign_in Factory(:user)
  end
  
  it "includes the helper" do
    view.should respond_to(:governor_header)
  end
  
  it "links to comment review page" do
    render
    rendered.should have_selector('a', :href => comments_path, :content => 'Manage Comments')
  end
end