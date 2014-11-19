class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :listings
  has_many :bookings
  has_many :booked_listings, through: :bookings, source: :listing

  def posted?(listing)
    listings.include?(listing)
  end
end
