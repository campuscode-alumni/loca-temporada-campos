require 'rails_helper'

feature 'Proposal approvement' do
  scenario 'successfully' do
    user = User.create(email: 'realtor@admin.com', password: '123456')
    realtor = Realtor.create(email: 'admin@admin.com.br', password: '123456')
    property_type = PropertyType.create!(name:'Casa de cachorro')
    region = Region.create(name: 'Barueri')
    property = Property.create!(title: 'Casa grande com canil', 
                                        description: 'Faça a festa do seu cãozinho', 
                                        property_type: property_type, 
                                        region: region, 
                                        area: 130, 
                                        room_quantity: 10, 
                                        main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')), 
                                        rent_purpose: 'Festa de cão', 
                                        maximum_guests: 20, 
                                        minimum_rent: 1, 
                                        maximum_rent: 2, 
                                        daily_rate: 160, 
                                        accessibility: false, 
                                        allow_pets: true, 
                                        allow_smokers: true, realtor: realtor)

    proposal = Proposal.create(start_date: '10-06-2018', 
                                end_date: '30-07-2018',
                                total_amount: 200, 
                                total_guests: 10, 
                                user: user, 
                                phone: '5464613846', 
                                rent_purpose: 'Festa de aniversário canina', 
                                pet: true, 
                                smoker: true, 
                                details: 'cachorros que fumam', 
                                property: property,
                                status: 'pending')
  
    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: realtor.email
    fill_in 'Senha', with: realtor.password
    click_on 'Acessar'

    click_on 'Ver propostas'
    click_on 'Detalhes'
    click_on 'Aprovar'
                
    proposal.reload
    expect(proposal).to be_approved
    expect(current_path).to eq proposals_path
    expect(page).to have_content('Proposta aprovado com sucesso!')
  end

  scenario ' do not show proposal already approved' do
    realtor = Realtor.create(email: 'admin@admin.com.br', password: '123456')
    user = User.create(email: 'realtor@admin.com', password: '123456')
    property_type = PropertyType.create(name:'Casa de cachorro')
    region = Region.create(name: 'Barueri')
    property = Property.create(title: 'Casa grande com canil', 
                                        description: 'Faça a festa do seu cãozinho', 
                                        property_type: property_type, 
                                        region: region, 
                                        area: 130, 
                                        room_quantity: 10, 
                                        main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')), 
                                        rent_purpose: 'Festa de cão', 
                                        maximum_guests: 20, 
                                        minimum_rent: 1, 
                                        maximum_rent: 2, 
                                        daily_rate: 160, 
                                        accessibility: false, 
                                        allow_pets: true, 
                                        allow_smokers: true, realtor: realtor)

    proposal = Proposal.create(start_date: '10-06-2018', 
                                  end_date: '30-07-2018',
                                  total_amount: 200, 
                                  total_guests: 10, 
                                  user: user, 
                                  phone: '5464613846', 
                                  rent_purpose: 'Festa de aniversário canina', 
                                  pet: true, 
                                  smoker: true, 
                                  details: 'cachorros que fumam', 
                                  property: property,
                                  status: 'pending')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: realtor.email
    fill_in 'Senha', with: realtor.password
    click_on 'Acessar'

    click_on 'Ver propostas'
    click_on 'Detalhes'
    click_on 'Aprovar'
    
    expect(page).not_to have_content('10-06-2018')
    expect(page).not_to have_content('Festa de aniversário canina')                      
  end
end
