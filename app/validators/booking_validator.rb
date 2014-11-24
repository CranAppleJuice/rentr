class BookingValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date < Date.today
      record.errors.add(:start_date, "has already passed")
    end

    if record.start_date > record.end_date
      record.errors.add(:end_date, "occurs before start date")
    end

    if record.start_date == record.end_date
      record.errors.add(:end_date, "is the same as start date")
    end

    if record.booking_outside?(record.listing)
      record.errors.add(:listing, "is unavailable for that date range")
    end

    record.listing.bookings.each do |booking|
      if record.end_date_falls_within_other?(booking) ||
        record.start_date_falls_within_other?(booking) ||
        record.booking_includes_other?(booking)

        record.errors.add(:booking, "overlaps another booking")
        break
      end
    end
  end
end
