require 'rails_helper'

  feature 'user sign in' do
    
    scenario 'from home page' do
      user = User.create!(email: 'ale@ale.com', password: '12345678')

      visit root_path

      click_on 'Fazer Login'

      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'

      expect(current_path).to eq root_path
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content("Olá #{user.email}")
      expect(page).to have_link('Sair')


    end

    scenario 'does not see Fazer Login' do
      user = User.create!(email: 'ale@ale.com', password: '12345678')

      visit root_path

      click_on 'Fazer Login'

      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'

      expect(page).not_to have_content('Fazer Login')
      
    end

    scenario 'and sign out successfully' do
      user = User.create!(email: 'ale@ale.com', password: '12345678')

      visit root_path

      click_on 'Fazer Login'

      fill_in 'Email', with: user.email
      fill_in 'Senha', with: user.password
      click_on 'Entrar'
      click_on 'Sair'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Signed out successfully.')
      expect(page).to have_link('Fazer Login')
      expect(page).not_to have_link('Sair')

    end
  end