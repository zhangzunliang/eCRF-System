class Relationship < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
