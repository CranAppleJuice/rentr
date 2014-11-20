class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing

  validates :start_date, presence: true
  validates :end_date, presence: true
end
