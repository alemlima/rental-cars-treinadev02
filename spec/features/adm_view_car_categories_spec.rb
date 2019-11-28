require 'rails_helper'

feature 'Adm view car categories' do
  scenario 'successfully' do
    CarCategory.create(name: 'Hatches')
    CarCategory.create(name: 'Sedans')

    visit root_path
    click_on 'Categoria'
    click_on 'Hatches'

    expect(page).to have_content('Hatches')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    CarCategory.create(name: 'Hatches')
    CarCategory.create(name: 'Sedans')

    visit root_path
    click_on 'Categoria'
    click_on 'Sedans'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end