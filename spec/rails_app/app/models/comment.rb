class Comment < ActiveRecord::Base
  include GovernorComments::Comment
end