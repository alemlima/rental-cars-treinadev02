require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)

    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)

    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'but does not have any manufacturers' do
    
    user = User.create!(email: 'ale@ale.com', password: '12345678', role: :admin)
    login_as(user, scope: :user)

    
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Não existem fabricantes cadastrados.')
  end

  scenario 'and must be logged in' do

    Manufacturer.create(name: 'Fiat')

    visit manufacturer_path(1)

    expect(current_path).to eq new_user_session_path
  end
end