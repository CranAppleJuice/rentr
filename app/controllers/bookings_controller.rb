class BookingsController < ApplicationController
  def create
    listing = Listing.find(params[:listing_id])
    current_user.booked_listings << listing

    redirect_to :back
  end

  def destroy

  end
end
