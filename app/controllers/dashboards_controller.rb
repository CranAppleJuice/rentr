class DashboardsController < ApplicationController
  def show
    @listings = Listing.all
  end
end
