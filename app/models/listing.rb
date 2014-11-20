class Listing < ActiveRecord::Base
  has_attached_file(
    :listing_image,
    styles: { :medium => "300x300>", :thumb => "100x100>" },
    default_url: "/images/:style/missing.png"
  )
  validates_attachment_content_type(
    :listing_image,
    content_type: /\Aimage\/.*\Z/
  )

  belongs_to :user
  has_many :bookers, through: :bookings, source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :housing_type, presence: true
  validates :price, presence: true
  validates :available_from, presence: true
  validates :available_to, presence: true
end
