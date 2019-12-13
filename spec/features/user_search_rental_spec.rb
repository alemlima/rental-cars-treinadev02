require 'rails_helper'

feature 'User search rental' do
  scenario  'successfully' do
      user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
      client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
      category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
      rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1234' )
      other_rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1237' )

      login_as user, scope: :user
      visit root_path
      click_on 'Locações'
      fill_in 'Código', with: rental.reservation_code
      click_on 'Buscar'

      expect(page).to have_content(rental.reservation_code)
      expect(page).not_to have_content(other_rental.reservation_code)
      expect(page).to have_content('1 locação encontrada:')
  end

  scenario  ' and more than one result was found' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
    client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
    category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1234' )
    other_rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1237' )
    another_rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'AAA1239' )

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: 'ABC'
    click_on 'Buscar'

    expect(page).to have_content(rental.reservation_code)
    expect(page).to have_content(other_rental.reservation_code)
    expect(page).to have_content('2 locações encontradas:')
  end

  scenario  'and no results where found' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
    client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
    category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1234' )

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: 'DCD'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma locação encontrada, por favor tente novamente.')
    
  end

  scenario  'and all fields of confirmed rental is show correctly ' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
    client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
    category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_model = CarModel.create!(name: 'Onix', year: '2020', manufacturer_id:1, car_category_id:1, fuel_type:'Flex', motorization:'1.0')
    subsidiary = Subsidiary.create!(name: 'São Paulo', cnpj: '12.989.776/0000-67', address: 'Rua dois, 33')
    car = Car.create!(car_model: car_model, license_plate: 'ABC1234', color: 'Verde', mileage: 0, subsidiary: subsidiary)
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1234' )

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    click_on 'ABC1234'
    select "#{car_model.name} - #{car.license_plate}", from: 'Carro'
    click_on 'Iniciar locação'
    
    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: 'ABC'
    click_on 'Buscar'

    expect(page).to have_content("#{car_model.name} - #{car.license_plate}")
    expect(page).to have_content(category.price)
    
  end


  scenario  'and return to rental index' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
    client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
    category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1234' )
    other_rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1237' )
    another_rental = Rental.create!(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'AAA1239' )

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: 'DCD'
    click_on 'Buscar'
    click_on 'Voltar'

    expect(current_path).to eq rentals_path
  end
end