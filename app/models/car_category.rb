class CarCategory < ApplicationRecord
  has_many :car_models
  has_many :rentals
end
