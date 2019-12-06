require 'rails_helper'

  feature 'user sign in' do
    
    scenario 'from home page' do
      User.create!(email: 'ale@ale.com', password: '12345678')

      visit root_path

      click_on 'Fazer Login'

      fill_in 'Email', with: 'ale@ale.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'

      expect(current_path).to eq root_path
      expect(page).to have_content('Olá ale@ale.com')

    end

    scenario 'does not see Fazer Login' do
      User.create!(email: 'ale@ale.com', password: '12345678')

      visit root_path

      click_on 'Fazer Login'

      fill_in 'Email', with: 'ale@ale.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'

      expect(page).not_to have_content('Fazer Login')
      
    end
  end