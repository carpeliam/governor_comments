require 'spec_helper'

describe Article do
  it "has many comments" do
    Article.instance_methods.should include 'comments'
    Article.new.comments.should be_an Array
  end
end