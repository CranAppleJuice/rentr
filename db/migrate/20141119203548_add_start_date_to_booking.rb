class AddStartDateToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :start_date, :date
    add_column :bookings, :end_date, :date
  end
end