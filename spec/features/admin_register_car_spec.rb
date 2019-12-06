require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    CarModel.create!(name: 'Onix', year: '2020', manufacturer_id:1, car_category_id:1, fuel_type:'Flex', motorization:'1.0')
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.989.776/0000-67', address: 'Rua dois, 33')

    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar novo carro'

    fill_in 'Placa', with: 'DBZ-1238'
    fill_in 'Cor', with: 'Prata'
    fill_in 'Quilometragem', with: 1000
    select 'Onix', from: 'Modelo'
    select 'São Paulo', from: 'Filial'
    click_on 'Enviar'

    expect(page).to have_content('Carro cadastrado com sucesso.')
    expect(page).to have_content('DBZ-1238')

  end

  scenario 'and return to home page' do
    
    Manufacturer.create!(name: 'Fiat')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    CarModel.create!(name: 'Onix', year: '2020', manufacturer_id:1, car_category_id:1, fuel_type:'Flex', motorization:'1.0')
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.989.776/0000-67', address: 'Rua dois, 33')

    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar novo carro'

    fill_in 'Placa', with: 'DBZ-1238'
    fill_in 'Cor', with: 'Prata'
    fill_in 'Quilometragem', with: 1000
    select 'Onix', from: 'Modelo'
    select 'São Paulo', from: 'Filial'
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and must fill in all fields' do
  
    Manufacturer.create!(name: 'Fiat')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    CarModel.create!(name: 'Onix', year: '2020', manufacturer_id:1, car_category_id:1, fuel_type:'Flex', motorization:'1.0')
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.989.776/0000-67', address: 'Rua dois, 33')

    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar novo carro'

    fill_in 'Placa', with: 'DBZ-1238'
    fill_in 'Cor', with: ''
    fill_in 'Quilometragem', with: 10
    select 'Onix', from: 'Modelo'
    select 'São Paulo', from: 'Filial'
    click_on 'Enviar'
    
    expect(page).to have_content('Todos os campos devem ser preenchidos.')
  
  end

  scenario 'and license plate must be unique' do
    Manufacturer.create!(name: 'Fiat')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    CarModel.create!(name: 'Onix', year: '2020', manufacturer_id:1, car_category_id:1, fuel_type:'Flex', motorization:'1.0')
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.989.776/0000-67', address: 'Rua dois, 33')
    Car.create!(license_plate: 'DBZ-1238', color: 'Prata', mileage: 10, car_model_id: 1, subsidiary_id: 1)

    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar novo carro'

    fill_in 'Placa', with: 'DBZ-1238'
    fill_in 'Cor', with: 'Prata'
    fill_in 'Quilometragem', with: 10
    select 'Onix', from: 'Modelo'
    select 'São Paulo', from: 'Filial'
    click_on 'Enviar'
    
    expect(page).to have_content('Placa já cadastrada no sistema.')
  end

  scenario 'and mileage must be a number greater than 0' do
    Manufacturer.create!(name: 'Fiat')
    CarCategory.create!(name: 'A', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    CarModel.create!(name: 'Onix', year: '2020', manufacturer_id:1, car_category_id:1, fuel_type:'Flex', motorization:'1.0')
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.989.776/0000-67', address: 'Rua dois, 33')

    visit root_path
    click_on 'Carros'
    click_on 'Cadastrar novo carro'

    fill_in 'Placa', with: 'DBZ-1238'
    fill_in 'Cor', with: 'Prata'
    fill_in 'Quilometragem', with: 'A'
    select 'Onix', from: 'Modelo'
    select 'São Paulo', from: 'Filial'
    click_on 'Enviar'
    
    expect(page).to have_content('Quilometragem deve ser um número maior ou igual a zero.')
  end
end
