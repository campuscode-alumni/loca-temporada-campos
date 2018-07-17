require 'rails_helper'

feature 'realtor only visualize its properties' do
    scenario 'successfully' do 
        realtor = Realtor.create(email: 'realtor@realtor.com', password: '123456')
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
                                    realtor: realtor)

        visit root_path
        click_on 'Entrar como corretor'
        fill_in 'Email', with: 'realtor@realtor.com'
        fill_in 'Senha', with: '123456'
        click_on 'Acessar'   
        click_on 'Meus imóveis' 

        expect(page).to have_css('h1', text: property.title)
        expect(page).to have_css('p', text: property.description)
        expect(page).to have_css('p', text: property.property_type.name)
        expect(page).to have_css('h1', text: property.region.name)
        expect(page).to have_css("img[src*='apartment.jpg']")
        expect(page).to have_css('p', text: property.area)
        expect(page).to have_css('p', text: property.room_quantity)
        expect(page).to have_css('p', text: property.maximum_guests)
        expect(page).to have_css('p', text: property.minimum_rent)
        expect(page).to have_css('p', text: property.maximum_rent)
        expect(page).to have_css('p', text: property.daily_rate)
        expect(page).to have_css('p', text: property.accessibility)
        expect(page).to have_css('p', text: property.allow_pets)
        expect(page).to have_css('p', text: property.allow_smokers)
        expect(page).to have_css('p', text: property.realtor.email)

    end

end
