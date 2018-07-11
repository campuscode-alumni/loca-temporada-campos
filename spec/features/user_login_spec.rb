require 'rails_helper'

feature 'user login' do
  scenario 'successfully' do   
    user = User.create(email: 'testeimersao@gmail.com', password:'123456')

    visit root_path
    click_on 'Login'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'do not log in with invalid email' do
    user = User.new(email: 'testeimersao@gmail.com', password:'123456')

    visit root_path
    click_on 'Login'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'

    expect(page).to have_content('Invalid Email or password.')
  end
end