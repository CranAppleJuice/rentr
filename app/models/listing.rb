class Listing < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :housing_type, presence: true
  validates :price, presence: true
  validates :available_from, presence: true
  validates :available_to, presence: true
end
