class Comment < ActiveRecord::Base
  include GovernorComments::Comment
  belongs_to :resource, :class_name => "Article"
end