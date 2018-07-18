require 'rails_helper'

feature 'Realtor edit region' do

  scenario 'successfully' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    praia_grande = Region.create(name: 'Praia Grande')

    visit root_path
    click_on 'Login como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'

    click_on praia_grande.name
    click_on 'Editar'

    fill_in 'Nome', with: 'Praia Grande SP'
    click_on 'Alterar'

    expect(page).to have_content('Região alterada com sucesso')
    expect(page).to have_css('h1', text: 'Praia Grande SP')
  end

  scenario 'and must fill all fields' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    praia_grande = Region.create(name: 'Praia Grande')

    visit root_path
    click_on 'Login como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'

    click_on praia_grande.name
    click_on 'Editar'

    fill_in 'Nome', with: ''
    click_on 'Alterar'

    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and realtor must be logged in' do
    praia_grande = Region.create(name: 'Praia Grande')

    visit edit_region_path(praia_grande)

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'and not see edit link' do
    praia_grande = Region.create(name: 'Praia Grande')

    visit region_path(praia_grande.id)

    expect(page).to_not have_content('Editar')
  end

end