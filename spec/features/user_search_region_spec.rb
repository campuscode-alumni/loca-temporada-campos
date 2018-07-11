require 'rails_helper'

feature 'Search by reagion' do

  scenario 'successfully' do

    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Casa') 
    property = Property.create(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type, region: region,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150)

    visit root_path
    click_on 'Copacabana'

    expect(page).to have_css('h1', text: region.name)
    expect(page).to have_css('h2', text: property.title)
    expect(page).to have_css('p', text: property.maximum_guests)
    expect(page).to have_css('p', text: property.property_type.name)
  end

end