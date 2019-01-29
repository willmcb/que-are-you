class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  has_one_attached :avatar

  has_many :associations
  has_many :associates, :through => :associations

  has_many :inverse_associations, :class_name => "association", :foreign_key => "associate_id"
  has_many :inverse_associations, :through => :inverse_associations, :source => :user

  has_secure_password

  def self.from_omniauth(auth)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      # p user
      # user.name = auth.info.name
      user.email = auth.info.email
    end
  end
  
end
