require 'rails_helper'

feature 'user sing Uo' do
  scenario 'successfully' do  
    

    visit root_path
    click_on 'Login'
    click_on 'Sign up'

    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    fill_in 'CPF', with:'11122233344'
    click_on 'Acessar'
    
    
    user = User.last
    expect(user.cpf).to eq "11122233344"


    


  end
end
