require 'rails_helper'

feature 'Admin register car categories' do
  scenario 'successfully' do

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar nova categoria'

    fill_in 'Nome', with: 'SUV'
    fill_in 'Diária', with: 150.5
    fill_in 'Seguro do carro', with: 40.5
    fill_in 'Seguro para terceiros', with: 45.5
    click_on 'Enviar'

    expect(page).to have_content('SUV')
    expect(page).to have_content(150.5)
    expect(page).to have_content(40.5)
    expect(page).to have_content(45.5)
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar nova categoria'

    fill_in 'Nome', with: 'Sedans'
    fill_in 'Diária', with: 100.3
    fill_in 'Seguro do carro', with: 25.3
    fill_in 'Seguro para terceiros', with: 35.3
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  
  end

  scenario ' and must be logged in' do
    visit new_car_category_path
    expect(current_path).to eq new_user_session_path
  end
end