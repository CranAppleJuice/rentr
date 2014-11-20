class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new(booking_params_plus_user_and(@listing))

    if @booking.save
      redirect_to listing_path(@listing)
    else
      render :new
    end
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.destroy

    listing = Listing.find(params[:listing_id])
    redirect_to listing_path(listing)
  end

  private

  def booking_params_plus_user_and(listing)
    booking_params = params.require(:booking).permit(:start_date, :end_date)
    booking_params[:user_id] = current_user.id
    booking_params[:listing_id] = listing.id
    booking_params
  end
end
