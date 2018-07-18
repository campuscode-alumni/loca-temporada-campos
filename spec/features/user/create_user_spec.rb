require 'rails_helper'

feature 'user sing Uo' do
  scenario 'successfully' do  
    visit root_path
    click_on 'Login como usuário'
    click_on 'Sign up'

    fill_in 'Email', with: 'teste@teste.com.br'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    fill_in 'CPF', with:'36751778821'
    click_on 'Acessar'
        
    user = User.last
    expect(user.cpf).to eq "36751778821"
  end

  # scenario 'must have valid cpf' do
  #   visit root_path
  #   click_on 'Login como usuário'
  #   click_on 'Sign up'

  #   fill_in 'Email', with: 'teste@teste.com.br'
  #   fill_in 'Senha', with: '12345678'
  #   fill_in 'Confirmar senha', with: '12345678'
  #   fill_in 'CPF', with:'11122233344'
  #   click_on 'Acessar'
        
  #   expect(User.count).to eq 0
  #   expect(page).to have_content('CPF inválido')
    
  # end
end
