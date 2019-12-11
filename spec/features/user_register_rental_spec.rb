require 'rails_helper'

feature 'User book a car rent' do
  scenario 'successfully' do

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
    login_as(user, scope: :user)
    
    client = Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'

    fill_in 'Data de início', with: Date.tomorrow
    fill_in 'Data de término', with: 2.days.from_now
    select  'Alex Santos - 395.069.980-51', from: 'Cliente'
    select  'A', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Locação efetuada com sucesso.')
    expect(page).to have_content('Alex Santos')
  
  end

  scenario 'and return to home page' do

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :employee)
    login_as(user, scope: :user)

    Client.create!(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'

    fill_in 'Data de início', with: Date.tomorrow  
    fill_in 'Data de término', with: 2.days.from_now
    select  'Alex Santos - 395.069.980-51', from: 'Cliente'
    select  'A', from: 'Categoria'
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path

  end

  scenario ' and must be logged in' do
    
    visit new_rental_path

    expect(current_path).to eq new_user_session_path
  end
end