require 'rails_helper'

feature 'realtor login' do

  scenario 'successfully' do

    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123123')

    visit root_path
    click_on 'Login como corretor'

    fill_in 'Email', with: realtor.email
    fill_in 'Senha', with: realtor.password
    click_on 'Acessar'

    expect(page).to have_content(realtor.email)
    expect(page).to have_content('Sair')
    expect(page).to have_content('Login efetuado com sucesso')
  end

  scenario 'do not log in with invalid email' do
    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123123')

    visit root_path
    click_on 'Login como corretor'

    fill_in 'Email', with: realtor.email
    fill_in 'Senha', with: '2222' 
    click_on 'Acessar'
    
    expect(page).to have_content('Invalido Email ou senha')
  end

  scenario 'realtor logout' do

    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123123')

    visit root_path
    click_on 'Login como corretor'

    fill_in 'Email', with: realtor.email
    fill_in 'Senha', with: realtor.password
    click_on 'Acessar'
    click_on 'Sair'

    expect(page).not_to have_content(realtor.email)
    expect(page).to have_content('Login como corretor')
  end

  scenario 'do not log in like user in the same session' do
    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123123')

    visit root_path
    click_on 'Login como corretor'

    fill_in 'Email', with: realtor.email
    fill_in 'Senha', with: realtor.password
    click_on 'Acessar'

    expect(page).not_to have_link('Login como usuário')
  end
end