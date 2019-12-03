class Manufacturer < ApplicationRecord
  validates :name, presence: { message: 'Todos os campos devem ser preenchidos.'}
  validates :name, uniqueness: { message: 'Já existe um fabricante com esse nome.'}
end
