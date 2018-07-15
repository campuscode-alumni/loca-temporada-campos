require 'rails_helper'

feature 'User see own proposals' do
    scenario 'successfully' do
        user = User.create(email:'teste@teste.com', password:'123456')
        region = Region.create(name: 'Gramado')
        property_type = PropertyType.create(name: 'Apartamento')
        property = Property.create(title: 'Apartamento em Gramado',
                                    description: 'Apartamento em Gramado, RS, com uma bosta vista para a Cascata do Caracol',
                                    property_type: property_type,
                                    region: region,
                                    rent_purpose: 'Férias com a família',
                                    area: 85, room_quantity: 3,
                                    accessibility: true, maximum_guests: 4,
                                    minimum_rent: 2, maximum_rent: 5,
                                    daily_rate: 350,
                                    main_photo: File.new(Rails.root.join('spec', 'support','gramadoAP.jpg')))

        proposal = Proposal.create(start_date: '20-07-2018', 
                                    end_date: '30-07-2018', total_amount: 200, 
                                    total_guests: 4, user: user, 
                                    phone: '5464613846', rent_purpose: 'Férias com a família', 
                                    pet: false, smoker: true, 
                                    details: 'Férias com a família em Gramados, 4 pessoas onde uma delas é fumante',
                                    property: property, status: 'pending')

        visit root_path
        click_on 'Login'                                
        
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password
        click_on 'Acessar'
        click_on 'Minhas propostas'

        expect(page).to have_css('h3', text: 'Propostas enviadas')
    end

    scenario 'user has no proposals' do
        user = User.create(email:'teste@teste.com', password:'123456')

        visit root_path
        click_on 'Login'                                
        
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password
        click_on 'Acessar'
        click_on 'Minhas propostas'

        expect(page).to have_content('Não existem propostas cadastradas')  
    end

    scenario 'user are not signed in' do
        
        visit root_path

        expect(page).not_to have_content('Minhas propostas')  

    end

end

