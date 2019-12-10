require 'rails_helper'

feature 'User search rental' do
  scenario  'successfully' do
      user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
      client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
      category = CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'ABC1234' )
      other_rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, car_category: category, reservation_code: 'AAA1234' )

      login_as user, scope: :user
      visit root_path
      click_on 'Locações'
      fill_in 'Código', with: rental.reservation_code
      click_on 'Buscar'

      expect(page).to have_content(rental.reservation_code)
      expect(page).not_to have_content(other_rental.reservation_code)
  end
end