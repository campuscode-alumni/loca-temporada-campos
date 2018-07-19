require 'rails_helper'

feature 'User see own proposals' do
    scenario 'successfully' do
        corretor = Realtor.create(email: 'corretor@teste.com', password: '123456')

        user = User.create(email:'teste@teste.com', password:'123456', cpf: '14688032390')
        another_user = User.create(email:'other@teste.com', password:'123456', cpf: '70414888022')

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
                                    main_photo: File.new(Rails.root.join('spec', 'support','gramadoAP.jpg')),
                                    realtor: corretor)

        other_property = Property.create(title: 'Apartamento em Bonito',
                                    description: 'Apartamento em Bonito para a Cascata do Caracol',
                                    property_type: property_type,
                                    region: region,
                                    rent_purpose: 'Férias com a família',
                                    area: 85, room_quantity: 3,
                                    accessibility: true, maximum_guests: 4,
                                    minimum_rent: 2, maximum_rent: 5,
                                    daily_rate: 350,
                                    main_photo: File.new(Rails.root.join('spec', 'support','gramadoAP.jpg')),
                                    realtor: corretor)

        user_proposal = Proposal.create(start_date: '20-07-2018', 
                                    end_date: '30-07-2018',
                                    total_guests: 4, user: user, 
                                    phone: '5464613846', rent_purpose: 'Férias com a família', 
                                    pet: false, smoker: true, 
                                    details: 'Férias com a família em Gramados, 4 pessoas onde uma delas é fumante',
                                    property: property, status: 'pending')

        other_proposal = Proposal.create(start_date: '21-08-2018', 
                                    end_date: '10-08-2018', 
                                    total_guests: 4, user: another_user, 
                                    phone: '5464613846', rent_purpose: 'isolamento', 
                                    pet: false, smoker: true, 
                                    details: 'Quero paz',
                                    property: other_property, status: 'pending')

        visit root_path
        click_on 'Login como usuário'                                
        
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password
        click_on 'Acessar'
        click_on 'Minhas propostas'

        expect(page).to have_css('h3', text: 'Propostas enviadas')
        expect(page).to have_css('h5', text: user_proposal.property.title)
        expect(page).not_to have_css('h5', text: other_proposal.property.title)     
    end

    scenario 'user has no proposals' do
        user = User.create(email:'teste@teste.com', password:'123456', cpf: '14688032390')

        visit root_path
        click_on 'Login como usuário'                               
        
        fill_in 'Email', with: user.email
        fill_in 'Senha', with: user.password
        click_on 'Acessar'
        click_on 'Minhas propostas'

        expect(page).to have_content('Não existem propostas cadastradas')
        expect(current_path).to eq(proposals_path)
    end

    scenario 'user are not signed in' do
        
        visit root_path

        expect(page).not_to have_content('Minhas propostas')  

    end

end

