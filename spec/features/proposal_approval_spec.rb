require 'rails_helper'

feature 'Proposal approvement' do
  scenario 'successfully' do
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
                                        allow_smokers: true)

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
    click_on 'Ver propostas'
    click_on 'Detalhes'
    click_on 'Aprovar'
                
    proposal.reload
    expect(proposal.approved?).to eq true
    expect(current_path).to eq proposals_path
    expect(page).to have_content('Proposta aprovado com sucesso!')
  end

  scenario ' do not show proposal already approved' do
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
                                        allow_smokers: true)

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
                                  status: 'approved')

    #  Terminar o cenário com uma proposta de status pendente
    
    visit root_path
    click_on 'Ver propostas'
    

    expect(page).not_to have_content(proposal.start_date)
    expect(page).not_to have_content(proposal.end_date)
    expect(page).not_to have_content(proposal.rent_purpose)
    expect(page).not_to have_content(proposal.status)
                                        
  end
end
