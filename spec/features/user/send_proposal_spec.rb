require 'rails_helper'

feature 'send proposal' do

  scenario 'successfully' do
    user = User.create!(email: 'testeimersao@gmail.com', password:'123456', cpf: '14688032390')
    realtor = Realtor.create!(email: 'corretor@corretora.com', password: '123456')
    duartina = Region.create!(name: 'Duartina')
    property_type_casa = PropertyType.create(name: 'Casa')
    casa = Property.create!(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type_casa, region: duartina,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)
    visit root_path
    click_on 'Login como usuário'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'
    click_on 'Duartina'
    click_on 'Proposta'

    fill_in 'Data de chegada', with: '30/01/2018'
    fill_in 'Data de saída', with: '06/02/2018'
    fill_in 'Número de hóspedes', with: '2'
    fill_in 'Finalidade da proposta', with: 'Festa'
    check 'Animal'
    uncheck 'Fumante'
    click_on 'Enviar'

    expect(page).to have_content('Enviado')

    all_proposals = Proposal.all
    expect(all_proposals.count).to eq 1
  end

  scenario 'with not logged user' do
    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    duartina = Region.create(name: 'Duartina')
    property_type_casa = PropertyType.create(name: 'Casa')
    casa = Property.create(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type_casa, region: duartina,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)

    visit root_path
    click_on 'Duartina'
    click_on 'Proposta'

    expect(page).to have_content("Para continuar, faça login ou registre-se.")
  end

  scenario 'user send proposal and proposal do not match minimum_rent' do
    user = User.create!(email: 'testeimersao@gmail.com', password:'123456', cpf: '14688032390')
    realtor = Realtor.create!(email: 'corretor@corretora.com', password: '123456')
    duartina = Region.create!(name: 'Duartina')
    property_type_casa = PropertyType.create!(name: 'Casa')
    property = Property.create!(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type_casa, region: duartina,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)
    visit root_path
    click_on 'Login como usuário'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'
    click_on 'Duartina'
    click_on 'Proposta'

    fill_in 'Data de chegada', with: '30/01/2018'
    fill_in 'Data de saída', with: '02/02/2018'
    fill_in 'Número de hóspedes', with: '2'
    fill_in 'Finalidade da proposta', with: 'Festa'
    check 'Animal'
    uncheck 'Fumante'
    click_on 'Enviar'             
    
    expect(page).to have_content("Quantidade de dias minima para a locação é de: #{property.minimum_rent}")
  end 

  scenario 'user send proposal and proposal do not match allow_smokers' do
    user = User.create!(email: 'testeimersao@gmail.com', password:'123456', cpf: '14688032390')
    realtor = Realtor.create!(email: 'corretor@corretora.com', password: '123456')
    duartina = Region.create!(name: 'Duartina')
    property_type_casa = PropertyType.create!(name: 'Casa')
    property = Property.create!(title: 'Casa', 
                                description: 'Casa na praia',
                                property_type: property_type_casa, 
                                region: duartina,
                                rent_purpose: 'Festa', 
                                area: '100', 
                                room_quantity:'3',
                                accessibility: true, 
                                maximum_guests:'1',
                                minimum_rent: 5,
                                maximum_rent: 10, 
                                daily_rate: 150,
                                allow_smokers: false,
                                main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                                realtor: realtor)
    visit root_path
    click_on 'Login como usuário'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'
    click_on 'Duartina'
    click_on 'Proposta'

    fill_in 'Data de chegada', with: '30/01/2018'
    fill_in 'Data de saída', with: '02/02/2018'
    fill_in 'Número de hóspedes', with: '2'
    fill_in 'Finalidade da proposta', with: 'Festa'
    check 'Animal'
    check 'Fumante'
    click_on 'Enviar'   

    # expect(page).to have_content("Nesta propriedade não é permitido a presença de fumantes!")
  end
end
