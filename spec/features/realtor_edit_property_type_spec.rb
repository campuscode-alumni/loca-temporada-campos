require 'rails_helper'

feature 'Realtor edit property type' do

  scenario 'successfully' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    tipo_apartamento = PropertyType.create(name: 'Apartamento')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'

    visit property_type_path(tipo_apartamento.id)
    click_on 'Editar'

    fill_in 'Nome', with: 'Apartamento grande'
    click_on 'Alterar'

    expect(page).to have_css('h1', text: 'Apartamento grande')
    expect(page).to have_content('Tipo do imóvel alterado com sucesso')
  end

  scenario 'and must fill all fields' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    tipo_apartamento = PropertyType.create(name: 'Apartamento')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'

    visit property_type_path(tipo_apartamento.id)
    click_on 'Editar'

    fill_in 'Nome', with: ''
    click_on 'Alterar'

    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and realtor must be logged in' do
    tipo_apartamento = PropertyType.create(name: 'Apartamento')

    visit edit_property_type_path(tipo_apartamento.id)

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'and not see edit link' do
    tipo_apartamento = PropertyType.create(name: 'Apartamento')

    visit property_type_path(tipo_apartamento.id)

    expect(page).to_not have_content('Editar')
  end

end