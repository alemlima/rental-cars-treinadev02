require 'rails_helper'

feature 'Adm view subsidiarys' do
  scenario 'successfully' do
    Subsidiary.create(name: 'São Paulo')
    Subsidiary.create(name: 'Campinas')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'

    expect(page).to have_content('São Paulo')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    Subsidiary.create(name: 'São Paulo')
    Subsidiary.create(name: 'Campinas')

    visit root_path
    click_on 'Filiais'
    click_on 'Campinas'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end