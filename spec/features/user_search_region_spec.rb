require 'rails_helper'

feature 'Search by reagion' do

  scenario 'successfully' do
    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    paulista = Region.create(name: 'Paulista')
    copacabana = Region.create(name: 'Copacabana')
    property_type_casa = PropertyType.create(name: 'Casa')
    property_type_apartamento = PropertyType.create(name: 'Aparatamento')  
    casa = Property.create(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type_casa, region: copacabana,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)
    apartamento = Property.create(title: 'Apartamento', description: 'Casa na praia',
                            property_type: property_type_apartamento, region: paulista,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'2', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)                      

    visit root_path
    click_on 'Copacabana'

    expect(page).to have_css('h1', text: copacabana.name)
    expect(page).to have_css('h2', text: casa.title)
    expect(page).to have_css('p', text: casa.maximum_guests)
    expect(page).to have_css('p', text: casa.property_type.name)
    expect(page).to have_css("img[src*='apartment.jpg']")
    
    expect(page).to_not have_css('h1', text: paulista.name)
    expect(page).to_not have_css('h2', text: apartamento.title)
    expect(page).to_not have_css('p', text: apartamento.maximum_guests)
    expect(page).to_not have_css('p', text: apartamento.property_type.name)
  end

  scenario 'and not result' do
    region = Region.create(name: 'Ipanema')

    visit root_path
    click_on 'Ipanema'

    expect(page).to have_css('h1', text: region.name)
    expect(page).to have_content('Nenhum imovel para esta região')
  end

  scenario 'and two or more result' do
    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    copacabana = Region.create(name: 'Copacabana')
    property_type_casa = PropertyType.create(name: 'Casa')
    property_type_apartamento = PropertyType.create(name: 'Aparatamento')  
    casa = Property.create(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type_casa, region: copacabana,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)
    apartamento = Property.create(title: 'Apartamento', description: 'Casa na praia',
                            property_type: property_type_apartamento, region: copacabana,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'2', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 150,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)      
    visit root_path
    click_on 'Copacabana'

    expect(page).to have_css('h1', text: copacabana.name)
    expect(page).to have_css('h2', text: casa.title)
    expect(page).to have_css('p', text: casa.maximum_guests)
    expect(page).to have_css('p', text: casa.property_type.name)
    expect(page).to have_css("img[src*='apartment.jpg']")
    
    expect(page).to have_css('h1', text: copacabana.name)
    expect(page).to have_css('h2', text: apartamento.title)
    expect(page).to have_css('p', text: apartamento.maximum_guests)
    expect(page).to have_css('p', text: apartamento.property_type.name)
    expect(page).to have_css("img[src*='apartment.jpg']")
  
  end

  scenario 'and not see edit button' do
    praia_grande = Region.create(name: 'Praia Grande')

    visit root_path
    click_on 'Praia Grande'

    expect(page).to_not have_content('Editar')
  end

end
