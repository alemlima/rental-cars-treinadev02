require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    
    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Alex Santos'
    fill_in 'CPF', with: '228.456.789-98'
    fill_in 'Email', with: 'alex.s@gmail.com'
    click_on 'Enviar'

    expect(page).to have_content('Cliente cadastrado com sucesso')
    expect(page).to have_content('Alex Santos')
  end

  scenario 'and return to home page' do

    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)
    
    visit root_path
    
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'Alex Santos'
    fill_in 'CPF', with: '228.456.789-98'
    fill_in 'Email', with: 'alex.s@gmail.com'
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario ' and must be logged in' do
    
    visit new_client_path

    expect(current_path).to eq new_user_session_path
  end

end