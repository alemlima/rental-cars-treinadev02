require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    
    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)

    CarCategory.create!(name: 'SUV', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)

    visit root_path
    click_on 'Categorias'
    click_on 'SUV'
    click_on 'Editar'

    fill_in 'Nome', with: 'Sedans'
    fill_in 'Diária', with: 105.5
    fill_in 'Seguro do carro', with: 35.5
    fill_in 'Seguro para terceiros', with: 40.5
    click_on 'Enviar'

    expect(page).to have_content('Categoria atualizada com sucesso.')
    expect(page).to have_content('Sedans')
    expect(page).to have_content(105.5)
    expect(page).to have_content(35.5)
    expect(page).to have_content(40.5)
    expect(page).to have_link('Voltar')

  end

  scenario 'and return to home page' do
    CarCategory.create!(name: 'SUV', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)

    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'
    click_on 'SUV'
    click_on 'Editar'

    fill_in 'Nome', with: 'Sedans'
    fill_in 'Diária', with: 105.5
    fill_in 'Seguro do carro', with: 35.5
    fill_in 'Seguro para terceiros', with: 40.5
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path 
  end

  scenario ' and must be logged in' do
    CarCategory.create!(name: 'SUV', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    
    visit edit_car_category_path(1)

    expect(current_path).to eq new_user_session_path
  end
  
end