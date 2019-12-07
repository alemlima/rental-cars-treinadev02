require 'rails_helper'

feature 'Admim register subsidiary' do
  scenario 'successfully' do

    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)
    
    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '12.345.678/9000-00'
    fill_in 'Endereço', with: 'Rua escorrega lá vai um, 456'
    click_on 'Enviar'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('12.345.678/9000-00')
    expect(page).to have_content('Rua escorrega lá vai um, 456')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do

    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Filiais'
    click_on 'Cadastrar nova filial'

    fill_in 'Nome', with: 'Campinas'
    fill_in 'CNPJ', with: '33.345.332/9654-00'
    fill_in 'Endereço', with: 'Rua da bica, 123'
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  
  end

  scenario ' and must be logged in' do
    
    visit new_subsidiary_path

    expect(current_path).to eq new_user_session_path
  end

end