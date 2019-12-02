class Manufacturer < ApplicationRecord
  validates :name, presence: { message: ' Todos os campos devem ser preenchidos'}
  validates :name, uniqueness: { message: ' Nome já está em uso'}
end
