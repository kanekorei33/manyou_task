class User < ApplicationRecord
  has_many :task
  validates :email, uniqueness: true
  before_validation { email.downcase! }
end
