class Association < ApplicationRecord
  belongs_to :user
  belongs_to :associate, class_name: 'User'
end
