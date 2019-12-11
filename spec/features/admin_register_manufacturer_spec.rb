require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)
    
    visit root_path
    
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)
    
    visit new_manufacturer_path

    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Todos os campos devem ser preenchidos.')
  end

  scenario 'and name must be unique' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)

    Manufacturer.create!(name: 'Fiat')

    visit new_manufacturer_path

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Já existe um fabricante com esse nome.')
  end

  scenario 'and return to home page' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)
    
    visit new_manufacturer_path

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path

  end

  scenario ' and must be logged in' do
    visit new_manufacturer_path

    expect(current_path).to eq new_user_session_path
  end

end