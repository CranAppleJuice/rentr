class ListingsController < ApplicationController
  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    current_user.listings << @listing

    if @listing.save
      redirect_to dashboard_path
    else
      redirect_to :back
    end
  end

  def edit
  end

  def delete
  end

  private

  def listing_params
    params.require(:listing).permit(
      :title,
      :description,
      :location,
      :housing_type,
      :price,
      :available_from,
      :available_to
    )
  end
end
