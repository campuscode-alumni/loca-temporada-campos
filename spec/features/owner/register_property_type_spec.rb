require 'rails_helper'

feature 'Register Property Type' do
  scenario 'successfully' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'
    
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Cadastrar'

    expect(page).to have_css('p', text: 'Tipo do imóvel cadastrado com sucesso')
    expect(page).to have_css('h1', text: 'Apartamento')
  end

  scenario 'and leave blank fields' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'
    
    click_on 'Cadastrar tipo de imóvel'
    click_on 'Cadastrar'

    expect(page).to have_content('Você deve preencher todos os campos')
    expect(page).to have_content('Name não pode ficar em branco')
  end

  scenario 'and must be logged as realtor' do

    visit root_path
    click_on 'Cadastrar tipo de imóvel'

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end
end
