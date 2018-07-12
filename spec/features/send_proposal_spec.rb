require 'rails_helper'

feature 'send proposal' do

  scenario 'successfully' do

    user = User.create(email: 'testeimersao@gmail.com', password:'123456')
    duartina = Region.create(name: 'Duartina')
    property_type_casa = PropertyType.create(name: 'Casa')
    casa = Property.create(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type_casa, region: duartina,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')))
    visit root_path
    click_on 'Login'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'
    click_on 'Duartina'
    click_on 'Proposta'

    fill_in 'Data de chegada', with: '01/30/2018'
    fill_in 'Data de saída', with: '02/28/2018'
    fill_in 'Número de hóspedes'
    fill_in 'Finalidade da proposta', with: ''
    check 'Animal'
    uncheck 'Fumante'
    click_on 'Enviar'

    
    
    

  end

end