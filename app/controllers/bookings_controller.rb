class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    listing = Listing.find(params[:listing_id])
    booking = Booking.new(booking_params)

    if booking.save
      current_user.bookings << booking
      listing.bookings << booking

      redirect_to listing_path(listing)
    else
      redirect_to :back
    end
  end

  def destroy
    listing = Listing.find(params[:listing_id])
    booking = Booking.find(params[:id])
    booking.destroy

    redirect_to listing_path(listing)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
