require 'rails_helper'

  feature 'User confirm scheduled rental' do
    scenario 'successfully' do
      
      user = User.create!(email: 'ale@ale.com', password: '12345678')
      login_as(user, scope: :user)

      client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')

      category = CarCategory.create!(name: 'A', 
                                    daily_rate: 135.5, 
                                    car_insurance: 45.6, 
                                    third_party_insurance: 50.7)

      Manufacturer.create!(name: 'Fiat')

      car_model = CarModel.create!(name: 'Onix', 
                            year: '2020', 
                            manufacturer_id:1, 
                            car_category_id:1, 
                            fuel_type:'Flex', 
                            motorization:'1.0')

      
      subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: '12.989.776/0000-67', address: 'Rua dois, 33')

      car = Car.create!(car_model: car_model, license_plate: 'ABC1234',
                        color: 'Verde', mileage: 0, subsidiary: subsidiary)
      
      rental = Rental.create!(start_date: Date.tomorrow, 
                          end_date: 2.days.from_now, 
                          client: client, 
                          car_category: category, 
                          reservation_code: 'AAA123')
      
      visit root_path
      click_on 'Locações'
      click_on 'AAA123'
      select car.license_plate, from: 'Carro'
      click_on 'Iniciar locação'

      expect(page).to have_content('Locação efetivada com sucesso.')
      expect(page).not_to have_link('Inicar locação')
      rental.reload
      car.reload
      expect(rental).to be_in_progress
      expect(car).to be_rented
      
    end
  end

  