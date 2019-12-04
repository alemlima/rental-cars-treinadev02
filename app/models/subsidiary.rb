class Subsidiary < ApplicationRecord
  validates :name, uniqueness: { message: 'Já existe uma filial com esse nome.'}
  validates :cnpj, format: { with: /\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}/, message: 'CNPJ inválido.'}
end
