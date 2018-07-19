require 'rails_helper' 

feature 'show proposal' do
  scenario 'successfully' do
    corretor = Realtor.create(email: 'corretor@teste.com', password: '123456')
    user = User.create(email:'teste@teste.com', password: '1231231')
    property_type = PropertyType.create(name: 'Apartamento')
    region = Region.create(name: 'Ceará')
    property = Property.create(title: 'Apartamento bonito', 
                                description: 'alugue já', 
                                property_type: property_type, 
                                region: region, 
                                area: 10, 
                                room_quantity: 2, 
                                main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                                rent_purpose: 'férias', 
                                room_quantity: 3, 
                                maximum_guests: 5, 
                                minimum_rent: 4, 
                                maximum_rent: 6,
                                daily_rate: 90, 
                                accessibility: true,
                                allow_pets: true, 
                                allow_smokers: true,
                                realtor: corretor)
                                
    proposal = Proposal.new(start_date: '10-10-2017',
                                end_date: '15-10-2017',
                                total_guests: 20,
                                user: user,
                                phone: '659546654', 
                                rent_purpose: 'férias', 
                                pet: true, 
                                smoker: true, 
                                details: 'Testando proposta', 
                                property: property,
                                status: 'pending')
    proposal.save

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'

    click_on 'Ver propostas'

    expect(page).to have_css('dd', text: proposal.user.email)
    expect(page).to have_css('dd', text: I18n.l(proposal.created_at, format: :short))
    expect(page).to have_css('dd', text: I18n.l(proposal.start_date, format: :long))
    expect(page).to have_css('dd', text: I18n.l(proposal.end_date, format: :long))
    expect(page).to have_css('dd', text: I18n.t("proposal.pet.#{proposal.pet}"))
    expect(page).to have_css('dd', text: proposal.rent_purpose)
    expect(page).to have_css('dd', text: 'R$ 450,00')

  end

  scenario 'show message without proposals' do
    user = User.create(email: 'teste@teste.com', password: '123456')
    property_type = PropertyType.create(name: 'Apartamento')
    region = Region.new(name: 'Ceará')
    property = Property.new(title: 'Apartamento bonito', 
                                description: 'alugue já', 
                                property_type: property_type, 
                                region: region, 
                                area: 10, 
                                room_quantity: 2, 
                                main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                                rent_purpose: 'férias', 
                                room_quantity: 3, 
                                maximum_guests: 5, 
                                minimum_rent: 4, 
                                maximum_rent: 6,
                                daily_rate: 90, 
                                accessibility: true,
                                allow_pets: true, 
                                allow_smokers: true)
                                
    proposal = Proposal.new(start_date: '10-10-2017',
                                end_date: '15-10-2017',
                                total_amount: 20,
                                total_guests: 20,
                                user: user,
                                phone: '659546654', 
                                rent_purpose: 'férias', 
                                pet: true, 
                                smoker: true, 
                                details: 'Testando proposta', 
                                property: property)

    visit root_path
    click_on 'Ver propostas'

    expect(page).to have_content('nao autorizado')
    expect(page).not_to have_css('dd', text: proposal.user.email)

  end
end