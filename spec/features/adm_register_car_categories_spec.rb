require 'rails_helper'

feature 'Adm register car categories' do
  scenario 'successfully' do
    
    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar nova categoria'

    fill_in 'Nome', with: 'SUV'
    fill_in 'Diária', with: 150
    fill_in 'Seguro do carro', with: 40
    fill_in 'Seguro terceirizado', with: 45
    click_on 'Cadastrar categoria'

    expect(page).to have_content('SUV')
    expect(page).to have_content(150)
    expect(page).to have_content(40)
    expect(page).to have_content(45)
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    visit root_path
    click_on 'Categorias'
    click_on 'Cadastrar nova categoria'

    fill_in 'Nome', with: 'Sedans'
    fill_in 'Diária', with: 100
    fill_in 'Seguro do carro', with: 25
    fill_in 'Seguro terceirizado', with: 35
    click_on 'Cadastrar categoria'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  
  end
end