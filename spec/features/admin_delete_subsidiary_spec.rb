require 'rails_helper'

feature 'Admin delete subsidiary' do
  xscenario 'successfully' do
    Subsidiary.create!(name: 'São Paulo', cnpj: '12.345.678/9000-00', address: 'Rua escorrega lá vai um, 456')
    Subsidiary.create!(name: 'Campinas', cnpj: '12.345.678/3400-00', address: 'Rua dois, 56')

    visit root_path
    click_on 'Filiais'
    #click_on 'São Paulo'
    click_on 'Apagar filial'

    expect(page).to have_content('Filial excluída com sucesso.')
    expect(pag).to not_have('São Paulo')
  end  
end
