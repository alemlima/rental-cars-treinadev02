class Client < ApplicationRecord
  has_many :rentals

  def full_description
    "#{name} - #{document}"
  end

end
