class CarCategory < ApplicationRecord
  has_many :car_models
  has_many :rentals
  has_many :cars, through: :car_models

  def price
    daily_rate + car_insurance + third_party_insurance
  end
end
