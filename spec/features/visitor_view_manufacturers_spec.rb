require 'rails_helper'

feature 'Visitor view manufacturers' do
  xscenario 'successfully' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  xscenario 'and return to home page' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')

    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  xscenario 'but does not have any manufacturers' do
    
    visit root_path
    click_on 'Fabricantes'

    expect(page).to have_content('Não existem fabricantes cadastrados.')
  end
end