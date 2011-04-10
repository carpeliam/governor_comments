class Guest < ActiveRecord::Base
    
  validates_presence_of     :name
  validates_format_of       :name,     :with => /\A[^[:cntrl:]\\<>\/&]*\z/,  :message => 'avoid non-printing characters and \\&gt;&lt;&amp;/ please.'
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_format_of       :email,    :with => /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i, :message => "should look like an email address."
  
  def website=(website)
    self[:website] = (website.blank? or website.starts_with? 'http://') ? website : 'http://' + website
  end
end