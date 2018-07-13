require 'rails_helper'

feature 'realtor login' do

  scenario 'successfully' do

    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123123')

    visit root_path
    click_on 'Entrar como corretor'

    fill_in 'Email', with: realtor.email
    fill_in 'Senha', with: realtor.password
    click_on 'Acessar'

    expect(page).to have_content('Signed in successfully.')
  end


end