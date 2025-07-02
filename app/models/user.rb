# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[user admin] }

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= 'user'
  end
end
