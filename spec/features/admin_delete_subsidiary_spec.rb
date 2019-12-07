require 'rails_helper'

feature 'Admin delete subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')
    Subsidiary.create!(name: 'Campinas', cnpj: '12.345.678/3400-00', address: 'Rua dois, 56')
    
    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Apagar filial'

    expect(page).to have_content('Filial excluída com sucesso.')
    expect(page).not_to have_content('São Paulo')
  end  

  scenario ' and must be logged in' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')
    visit subsidiary_path(1)

    expect(current_path).to eq new_user_session_path
  end
end
