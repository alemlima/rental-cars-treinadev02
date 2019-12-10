require 'rails_helper'

RSpec.describe Rental, type: :model do
  describe '.end_date_must_be_greater_than_start_date' do #método
    it 'success' do

      client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
      category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
      rental = Rental.new(start_date: Date.tomorrow, end_date: 2.days.from_now, client: client, car_category: category )
    
      rental.valid?

      expect(rental.errors).to be_empty
      #expect(rental.errors.empty?).to eq true
    end

    it 'end date less than start date' do

      rental = Rental.new(start_date: Date.tomorrow, end_date: Date.yesterday)
    
      rental.valid?

      expect(rental.errors.full_messages).to include('End date deve ser maior que data de início')#procura dentro da array se há essa msg
    end

    it 'end date equal start date' do
      
      rental = Rental.new(start_date: 2.days.from_now, end_date: 2.days.from_now)

      rental.valid?

      expect(rental.errors.full_messages).to include('As datas de início e término de locação devem ser diferentes')
    end

    it 'start date must be greater than today' do

      rental = Rental.new(start_date: Date.current, end_date: Date.tomorrow)

      rental.valid?

      expect(rental.errors.full_messages).to include('Start date deve ser maior que hoje')

    end
    
    it 'minimun rental is 1 day' do

      client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
      category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
      rental = Rental.new(start_date: Date.tomorrow, end_date: Date.tomorrow, client: client, car_category: category )

      rental.valid?

      expect(rental.errors.full_messages).to include('A locação mínima é de um(1) dia')
    end
  end
end