require 'rails_helper'

feature 'user login' do
  scenario 'successfully' do   
    user = User.create(email: 'testeimersao@gmail.com', password:'123456', cpf: '14688032390')

    visit root_path
    click_on 'Login como usuário'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'

    expect(page).to have_content('Login efetuado com sucesso.')
    expect(page).to have_content(user.email)
    expect(page).to have_link('Sair')
  end

  scenario 'do not log in with invalid email' do
    user = User.new(email: 'testeimersao@gmail.com', password:'123456', cpf: '14688032390')

    visit root_path
    click_on 'Login como usuário'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'

    expect(page).to have_content('Invalido Email ou senha')
  end

  scenario 'do not log in with realtor in the same session' do
    user = User.create(email: 'testeimersao@gmail.com', password:'123456', cpf: '14688032390')

    visit root_path
    click_on 'Login como usuário'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'

    expect(page).not_to have_link('Login como corretor')
  end

  scenario 'user logout' do
    user = User.create(email: 'testeimersao@gmail.com', password:'123456', cpf: '14688032390')

    visit root_path
    click_on 'Login como usuário'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'

    click_on 'Sair'

    expect(page).not_to have_content(user.email)
    expect(page).to have_content('Login como usuário')
  end

end
