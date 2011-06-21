require 'spec_helper'

describe Comment do
  it "is invalid if the commenter is invalid" do
    bad_guest = Guest.new
    bad_guest.should be_invalid
    good_guest = Guest.new(:name => 'name', :email => 'email@address.com')
    good_guest.should be_valid
    
    Comment.new(:content => 'some content', :commenter => bad_guest).should be_invalid
    Comment.new(:content => 'some content', :commenter => good_guest).should be_valid
  end
  
  it "has a working gravatar url" do
    # pulled off github
    dhh_gravatar = 'http://www.gravatar.com/avatar/ed9635566b34ade32274f510f0f9a6d2?s=140&r=pg&d=https%3A%2F%2Fa248.e.akamai.net%2Fassets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png'
    comment = Comment.new(:content => "I like ruby, yes", :commenter => Guest.new(:name => 'dhh', :email => 'david@loudthinking.com'))
    comment.gravatar_url(140, 'https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-140.png').should == dhh_gravatar
  end
end