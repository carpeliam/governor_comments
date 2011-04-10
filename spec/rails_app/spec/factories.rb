FactoryGirl.define do
  factory :article do |a|
    a.title "Some article"
  end
  
  factory :user do |u|
    u.email 'blago@mayor.cityofchicago.org'
    u.password 'ca$hmoney'
    u.password_confirmation 'ca$hmoney'
  end
  
  factory :comment do |c|
    c.title 'Awesome Comment'
    c.content 'This is an awesome comment'
  end
end