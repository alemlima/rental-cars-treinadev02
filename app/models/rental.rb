class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :car_category
  validates :end_date, :start_date, presence: :true
  validate :end_date_must_be_greater_than_start_date

  def end_date_must_be_greater_than_start_date
    return unless start_date.present? || end_date.present?

    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que data de início')
    end

    if start_date.eql?(Date.today)
      errors.add(:start_date, 'deve ser maior que hoje')
    end

    if end_date.eql?(Date.tomorrow)
      errors.add(:base, 'A locação mínima é de um(1) dia')
    end

    if start_date.eql?(end_date)
      errors.add(:base, 'As datas de início e término de locação devem ser diferentes')
    end
  end

end
