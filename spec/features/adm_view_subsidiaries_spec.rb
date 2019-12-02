require 'rails_helper'

feature 'Adm view subsidiarys' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')
    Subsidiary.create!(name: 'Campinas', cnpj: '33.345.332/9654-00', address: 'Rua da bica, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('12.345.678/9000-00')
    expect(page).to have_content('Rua escorrega lá vai um, 456')
    expect(page).to have_link('Voltar')

  end

  scenario 'and return to home page' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')
    Subsidiary.create!(name: 'Campinas', cnpj: '12.345.678/9000-00', address: 'Rua da bica, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'Campinas'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'if does not have any subsidiary' do

    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Não existem filiais cadastradas.')
    expect(page).to have_link('Voltar')

  end
end