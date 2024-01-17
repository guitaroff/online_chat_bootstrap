class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  DEFAULT_PASSWORD = ENV['DEFAULT_PASSWORD'] || 'Example123456_'
  after_create_commit { broadcast_append_to "users" }

  has_many :rooms, dependent: :destroy
  has_many :messages

  scope :all_except, -> (user_id) { where.not(id: user_id) }
end
