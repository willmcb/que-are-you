class Association < ApplicationRecord
  belongs_to :user
  belongs_to :associate, :class_name => 'User'
  validates_uniqueness_of :user_id, scope: :associate_id
end
