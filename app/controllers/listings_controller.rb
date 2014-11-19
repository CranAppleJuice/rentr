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
    @listing = Listing.find(params[:id])
  end

  def update
    listing = Listing.find(params[:id])

    if listing.update(listing_params)
      redirect_to dashboard_path
    else
      redirect_to :back
    end
  end

  def destroy
    listing = Listing.find(params[:id])
    listing.destroy

    redirect_to dashboard_path
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
      :available_to,
      :listing_image
    )
  end
end
