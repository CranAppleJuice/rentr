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
  has_many :bookings
  has_many :bookers, through: :bookings, source: :user

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :housing_type, presence: true
  validates :price, presence: true
  validates :available_from, presence: true
  validates :available_to, presence: true

  def is_booked_on_first_available_date?
    if bookings.exists?
      available_from == bookings.order(:start_date).first.start_date
    end
  end

  def is_booked_on_last_available_date?
    if bookings.exists?
      available_to == bookings.order(:end_date).last.end_date
    end
  end
end
