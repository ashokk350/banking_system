class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account, dependent: :destroy
  
  accepts_nested_attributes_for :account

  validates :user_name, :role, presence: true

  enum role: { manager: 'manager', user: 'user' }
end
