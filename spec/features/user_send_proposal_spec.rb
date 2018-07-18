require 'rails_helper'

feature 'send proposal' do

  scenario 'successfully' do
    realtor = Realtor.create(email:'realtor@admin.com', password: '123456')
    user = User.create(email: 'testeimersao@gmail.com', password:'123456')
    realtor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    duartina = Region.create(name: 'Duartina')
    property_type_casa = PropertyType.create(name: 'Casa')
    casa = Property.create(title: 'Casa', description: 'Casa na praia',
                            property_type: property_type_casa, region: duartina,
                            rent_purpose: 'Festa', area: '100', room_quantity:'3',
                            accessibility: true, maximum_guests:'1', minimum_rent: 5,
                            maximum_rent: 10, daily_rate: 100,
                            main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                            realtor: realtor)
    visit root_path
    click_on 'Login'
    
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Acessar'
    click_on 'Duartina'
    click_on 'Proposta'

    fill_in 'Data de chegada', with: '30/01/2018'
    fill_in 'Data de saída', with: '28/02/2018'
    fill_in 'Número de hóspedes', with: '2'
    fill_in 'Finalidade da proposta', with: 'Festa'
    check 'Vai levar animais?'
    uncheck 'Fumante?'
    click_on 'Enviar'

    last_proposal = Proposal.last
    expect(current_path).to eq (proposal_path(last_proposal.id))
    expect(page).to have_content('Proposta enviada com sucesso')
    expect(page).to have_css('h5', text: last_proposal.property.title)
    expect(page).to have_content('testeimersao@gmail.com')
    expect(page).to have_content("#{I18n.l last_proposal.created_at, format: :short}")
    expect(page).to have_css('dd', text: '30 de Janeiro de 2018')
    expect(page).to have_css('dd', text: '28 de Fevereiro de 2018')
    expect(page).to have_content('Vai levar animais? Sim')
    expect(page).to have_content('Finalidade da proposta: Festa')
    expect(page).to have_content('Valor total da locação: R$ 2.900,00')
    expect(page).not_to have_content('Aprovar')
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

end
