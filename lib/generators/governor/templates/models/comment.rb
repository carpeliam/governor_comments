class Comment < ActiveRecord::Base
  include GovernorComments::Comment
  belongs_to :resource, :<%= options[:polymorphic] ? 'polymorphic => :true' : %Q{class_name => "#{mapping.to.name}"} %>
end