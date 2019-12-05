require 'rails_helper'

feature 'User book a car rent' do
  scenario 'successfully' do
    Client.create!(name: 'Alex Santos', document:'234.876.456-99', email: 'alex@alex.com')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)

    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'

    fill_in 'Data de início', with: '05/12/2019'  
    fill_in 'Data de término', with: '09/12/2019'
    select  'Alex Santos', from: 'Cliente'
    select  'A', from: 'Categoria'
    click_on 'Enviar'

    expect(page).to have_content('Locação efetuada com sucesso.')
    expect(page).to have_content('Alex Santos')
  
  end

  scenario 'and return to home page' do
    Client.create!(name: 'Alex Santos', document:'234.876.456-99', email: 'alex@alex.com')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    
    visit root_path
    click_on 'Locações'
    click_on 'Agendar locação'

    fill_in 'Data de início', with: '05/12/2019'  
    fill_in 'Data de término', with: '09/12/2019'
    select  'Alex Santos', from: 'Cliente'
    select  'A', from: 'Categoria'
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path

  end

end