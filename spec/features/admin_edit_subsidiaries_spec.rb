require 'rails_helper'

feature 'Admin edits subisidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Campinas'
    fill_in 'CNPJ', with: '12.345.678/9000-80'
    fill_in 'Endereço', with: 'Rua dois, 33'
    
    click_on 'Enviar'

    expect(page).to have_content('Filial atualizada com sucesso.')
    expect(page).to have_content('Campinas')
    expect(page).to have_content('12.345.678/9000-80')
    expect(page).to have_content('Rua dois, 33')
    expect(page).to have_link('Voltar')
    
  end

  scenario 'and must be unique' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')
    Subsidiary.create!(name: 'Campinas', cnpj: '12.345.678/4000-10', address: 'Rua dois, 556')

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)


    visit root_path
    
    click_on 'Filiais'
    click_on 'Campinas'
    click_on 'Editar'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '12.345.678/9000-80'
    fill_in 'Endereço', with: 'Rua dois, 33'
    
    click_on 'Enviar'

    expect(page).to have_content('Já existe uma filial com esse nome.')
  end

  scenario 'and must have a valid cnpj' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)


    visit root_path
    
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: 'São Paulo'
    fill_in 'CNPJ', with: '12.345.678/900-80'
    fill_in 'Endereço', with: 'Rua dois, 33'
    
    click_on 'Enviar'

    expect(page).to have_content('CNPJ inválido.')
  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')

    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)

    visit root_path
    
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Campinas'
    fill_in 'CNPJ', with: '12.345.678/9003-80'
    fill_in 'Endereço', with: 'Rua dois, 33'
    
    click_on 'Enviar'
    click_on 'Voltar'

    expect(current_path).to eq root_path

  end

  scenario ' and must be logged in' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')
    visit edit_subsidiary_path(1)

    expect(current_path).to eq new_user_session_path
  end
end