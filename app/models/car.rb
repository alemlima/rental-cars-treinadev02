class Car < ApplicationRecord
  belongs_to :car_model
  belongs_to :subsidiary
  validates  :license_plate, :color, :mileage, :car_model_id, :subsidiary_id, presence: { message: 'Todos os campos devem ser preenchidos.'}
  validates :license_plate, uniqueness: { message: 'Placa já cadastrada no sistema.'}
  validates :mileage, numericality: { greater_than_or_equal_to: 0, message: 'Quilometragem deve ser um número maior ou igual a zero.' }
end
