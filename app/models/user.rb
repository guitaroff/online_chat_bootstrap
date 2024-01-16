class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  DEFAULT_PASSWORD = ENV['DEFAULT_PASSWORD'] || 'Example123456_'

  has_many :rooms, dependent: :destroy
  has_many :messages
end
