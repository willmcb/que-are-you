class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  has_many :associations, dependent: :destroy
  has_many :associates, through: :associations
  has_many :inverse_associations,
           class_name: 'Association',
           foreign_key: 'associate_id'
  has_many :inverse_associates, through: :inverse_associations, source: :user

  has_secure_password
end
