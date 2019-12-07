require 'rails_helper'

feature 'Adm view car categories' do
  scenario 'successfully' do

    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)
    
    #Arrange
    CarCategory.create(name: 'Hatches',daily_rate: 100, car_insurance: 50, third_party_insurance: 60)
    CarCategory.create(name: 'Sedans',daily_rate: 130, car_insurance: 60, third_party_insurance: 70)
    
    #Act
    visit root_path
    click_on 'Categorias'
    click_on 'Hatches'
    
    #Assert
    expect(page).to have_content('Hatches')
    expect(page).to have_content(100)
    expect(page).to have_content(50)
    expect(page).to have_content(60)
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do

    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)

    CarCategory.create(name: 'Hatches',daily_rate: 100, car_insurance: 50, third_party_insurance: 60)
    CarCategory.create(name: 'Sedans',daily_rate: 130, car_insurance: 60, third_party_insurance: 70)

    visit root_path
    click_on 'Categorias'
    click_on 'Sedans'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'if does not have any subsidiary' do

    user = User.create!(email: 'ale@ale.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Não existem categorias cadastradas.')
    expect(page).to have_link('Voltar')
  end

  scenario ' and must be logged in' do
    CarCategory.create!(name: 'SUV', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)
    
    visit car_category_path(1)

    expect(current_path).to eq new_user_session_path
  end

end