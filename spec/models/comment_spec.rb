require 'spec_helper'

describe Comment do
  before do
    @bad_guest = Guest.new
    @bad_guest.should be_invalid
    @good_guest = Guest.new(:name => 'name', :email => 'email@address.com')
    @good_guest.should be_valid
  end
  it "is invalid if the commenter is invalid" do
    Comment.new(:content => 'some content', :commenter => @bad_guest).should be_invalid
    Comment.new(:content => 'some content', :commenter => @good_guest).should be_valid
  end
end