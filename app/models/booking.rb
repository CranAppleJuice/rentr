class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :start_date_is_in_future,
    :date_range_is_valid,
    :dates_are_not_equal,
    :listing_is_available,
    :does_not_overlap_other_bookings

  private

  def start_date_is_in_future
    if start_date < Date.today
      errors.add(:start_date, "is in the past!")
    end
  end

  def date_range_is_valid
    if start_date > end_date
      errors.add(:end_date, "occurs before start date")
    end
  end

  def dates_are_not_equal
    if start_date == end_date
      errors.add(:end_date, "is the same as start date")
    end
  end

  def listing_is_available
    listing = Listing.find(listing_id)
    if (start_date < listing.available_from || end_date > listing.available_to)
      errors.add(:listing, "is unavailable for that date range")
    end
  end

  def does_not_overlap_other_bookings
    listing = Listing.find(listing_id)
    listing.bookings.each do |booking|
      if (end_date > booking.start_date && end_date < booking.end_date) ||
        (start_date > booking.start_date && start_date < booking.end_date) ||
        (start_date < booking.start_date && end_date > booking.end_date)
        errors.add(:booking, "overlaps another booking")
        break
      end
    end
  end
end
