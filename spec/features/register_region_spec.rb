require 'rails_helper'

feature 'Register Region' do
  scenario 'successfully' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'
    
    click_on 'Cadastrar região'
    fill_in 'Nome', with: 'Copacabana'
    click_on 'Cadastrar'

    expect(page).to have_css('p', text: 'Região cadastrada com sucesso')
    expect(page).to have_css('h1', text: 'Copacabana')
  end

  scenario 'and leave blank fields' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'
    
    click_on 'Cadastrar região'
    click_on 'Cadastrar'

    expect(page).to have_content('Você deve preencher todos os campos')
    expect(page).to have_content('Name não pode ficar em branco')
  end

  scenario 'and must be logged as realtor' do
    visit new_region_path

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end
end
