class Booking < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :user
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true

  validates_with BookingValidator

  def starts_on_first_available_date?
    start_date == listing.available_from
  end

  def ends_on_last_available_date?
    end_date == listing.available_to
  end

  def booking_outside?(listing)
    start_date < listing.available_from ||
    end_date > listing.available_to
  end

  def end_date_falls_within_other?(booking)
    end_date > booking.start_date &&
    end_date <= booking.end_date
  end

  def start_date_falls_within_other?(booking)
    start_date >= booking.start_date &&
    start_date < booking.end_date
  end

  def booking_includes_other?(booking)
    start_date <= booking.start_date &&
    end_date >= booking.end_date
  end
end
