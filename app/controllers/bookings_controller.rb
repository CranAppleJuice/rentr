class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @listing = Listing.find(params[:listing_id])

    new_booking_params =  booking_params
    new_booking_params[:user_id] = current_user.id
    new_booking_params[:listing_id] = @listing.id
    @booking = Booking.new(new_booking_params)

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

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
