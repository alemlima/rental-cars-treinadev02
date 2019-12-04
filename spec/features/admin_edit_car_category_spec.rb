require 'rails_helper'

feature 'Admin edits car category' do
  scenario 'successfully' do
    CarCategory.create!(name: 'SUV', daily_rate: 135.5, car_insurance: 45.6, third_party_insurance: 50.7)

    visit root_path
    click_on 'Categorias'
    click_on 'SUV'
    click_on 'Editar'

    fill_in 'Nome', with: 'Sedans'
    fill_in 'Diária', with: 105.5
    fill_in 'Seguro do carro', with: 35.5
    fill_in 'Seguro terceirizado', with: 40.5
    click_on 'Enviar'

    expect(page).to have_content('Categoria atualizada com sucesso.')
    expect(page).to have_content('Sedans')
    expect(page).to have_content(105.5)
    expect(page).to have_content(35.5)
    expect(page).to have_content(40.5)
    expect(page).to have_link('Voltar')

  end
  
end