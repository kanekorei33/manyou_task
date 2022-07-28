class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true,  length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_update :admin_cannot_update
  before_destroy :admin_cannot_delete
  has_many :tasks, dependent: :destroy


  private

  def admin_cannot_update
    throw :abort if User.where(admin: true).count == 1 && self.admin_change == [true, false]
  end

  def admin_cannot_delete
    throw :abort if User.where(admin: true).count == 1 && self.admin == true
  end
end
