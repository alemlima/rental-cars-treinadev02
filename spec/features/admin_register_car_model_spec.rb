require 'rails_helper'

feature 'Admin register car model'do
  scenario 'successfully'do
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    CarCategory.create!(name: 'A', daily_rate: 100, car_insurance:50, third_party_insurance: 90)
    CarCategory.create!(name: 'B', daily_rate: 90, car_insurance:40, third_party_insurance: 80)
  
    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Registrar novo modelo'

    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select  'Chevrolet', from: 'Fabricante'
    select  'A', from: 'Categoria'

    click_on 'Enviar'

    expect(page).to have_content('Modelo registrado com sucesso.')
    expect(page).to have_css('h1', text: 'Onix')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Motorização: 1.0')
    expect(page).to have_content('Combustível: Flex')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Categoria: A')
  end

  scenario 'and return to home page' do
    Manufacturer.create!(name: 'Chevrolet')
    CarCategory.create!(name: 'B', daily_rate: 90, car_insurance:40, third_party_insurance: 80)
  
    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Registrar novo modelo'

    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustível', with: 'Flex'
    select  'Chevrolet', from: 'Fabricante'
    select  'B', from: 'Categoria'

    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end