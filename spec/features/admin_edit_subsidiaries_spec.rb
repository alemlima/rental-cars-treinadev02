require 'rails_helper'

feature 'Admin edits subisidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'
    click_on 'Editar'

    fill_in 'Nome', with: 'Campinas'
    fill_in 'CNPJ', with: '12.345.678/9000-80'
    fill_in 'Endereço', with: 'Rua dois, 33'
    
    click_on 'Enviar'

    expect(page).to have_content('Filial atualizada com sucesso.')
    expect(page).to have_content('Campinas')
    expect(page).to have_content('12.345.678/9000-80')
    expect(page).to have_content('Rua dois, 33')
    expect(page).to have_link('Voltar')
    
  end
end