class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :yachts
  has_many :bookings

  validates :email, uniqueness: true
  validates :email, presence: true

  has_one_attached :photo
end
