require 'rails_helper'

feature 'Realtor edit property' do

  scenario 'successfully' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    tipo_mansao = PropertyType.create(name: 'Mansão')
    jardins = Region.create(name: 'Jardins')
    bela_mansao_jardins = Property.create(title: 'Bela mansao Jardins', description: 'A mansão mais bela dos Jardins',
                              property_type: tipo_mansao, region: jardins,
                              rent_purpose: 'Casamento', area: '500', room_quantity:'10',
                              accessibility: true, maximum_guests:'12', minimum_rent: 5,
                              maximum_rent: 10, daily_rate: 1000, 
                              main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                              realtor: corretor)

    visit root_path
    click_on 'Login como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'

    visit property_path(bela_mansao_jardins.id)

    click_on 'Editar'

    fill_in 'Descrição', with: 'A maior e mais bela mansão dos Jardins'
    fill_in 'Finalidade do imóvel', with: 'Festas, casamentos, exposições de arte'
    fill_in 'Área', with: '1000'
    fill_in 'Quantidade de cômodos', with: 30
    check 'Aceita animais'
    fill_in 'Ocupação máxima', with: 80
    fill_in 'Mínimo de diárias', with: 10
    fill_in 'Máximo de diárias', with: 30
    fill_in 'Valor da diária', with: 8000
    click_on 'Alterar'

    expect(page).to have_css('p', text: 'Imóvel alterado com sucesso')
    expect(page).to have_css('h1', text: 'Bela mansao Jardins')
    expect(page).to have_css('p', text: 'A maior e mais bela mansão dos Jardins')
    expect(page).to have_css('li', text: jardins.name)
    expect(page).to have_css('li', text: tipo_mansao.name)
    expect(page).to have_css('li', text: 'Festas, casamentos, exposições de arte')
    expect(page).to have_css('li', text: '1000m²')
    expect(page).to have_css('li', text: '30')
    expect(page).to have_css('li', text: 'Possui acessibilidade: Sim')
    expect(page).to have_css('li', text: 'Aceita animais: Sim')
    expect(page).to have_css('li', text: 'Aceita fumantes: Não')
    expect(page).to have_css('li', text: '80')
    expect(page).to have_css('li', text: '10')
    expect(page).to have_css('li', text: '30')
    expect(page).to have_css('li', text: 'R$ 8000')
    expect(page).to have_css("img[src*='apartment.jpg']")
  end

  scenario 'and must fill property title' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    tipo_mansao = PropertyType.create(name: 'Mansão')
    jardins = Region.create(name: 'Jardins')
    bela_mansao_jardins = Property.create(title: 'Bela mansao Jardins', description: 'A mansão mais bela dos Jardins',
                              property_type: tipo_mansao, region: jardins,
                              rent_purpose: 'Casamento', area: '500', room_quantity:'10',
                              accessibility: true, maximum_guests:'12', minimum_rent: 5,
                              maximum_rent: 10, daily_rate: 1000, 
                              main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                              realtor: corretor)

    visit root_path
    click_on 'Login como corretor'
    fill_in 'Email', with: corretor.email
    fill_in 'Senha', with: corretor.password
    click_on 'Acessar'

    visit property_path(bela_mansao_jardins.id)

    click_on 'Editar'

    fill_in 'Título', with: ''
    click_on 'Alterar'

    expect(page).to have_css('p', text: 'Você deve preencher todos os campos')
  end

  scenario 'and realtor must be logged in' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    tipo_mansao = PropertyType.create(name: 'Mansão')
    jardins = Region.create(name: 'Jardins')
    bela_mansao_jardins = Property.create(title: 'Bela mansao Jardins', description: 'A mansão mais bela dos Jardins',
                              property_type: tipo_mansao, region: jardins,
                              rent_purpose: 'Casamento', area: '500', room_quantity:'10',
                              accessibility: true, maximum_guests:'12', minimum_rent: 5,
                              maximum_rent: 10, daily_rate: 1000, 
                              main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                              realtor: corretor)

    visit edit_property_path(bela_mansao_jardins.id)

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'and only realtor see edit link' do
    corretor = Realtor.create(email: 'corretor@corretora.com', password: '123456')
    tipo_mansao = PropertyType.create(name: 'Mansão')
    jardins = Region.create(name: 'Jardins')
    bela_mansao_jardins = Property.create(title: 'Bela mansao Jardins', description: 'A mansão mais bela dos Jardins',
                              property_type: tipo_mansao, region: jardins,
                              rent_purpose: 'Casamento', area: '500', room_quantity:'10',
                              accessibility: true, maximum_guests:'12', minimum_rent: 5,
                              maximum_rent: 10, daily_rate: 1000, 
                              main_photo: File.new(Rails.root.join('spec', 'support','apartment.jpg')),
                              realtor: corretor)

    visit property_path(bela_mansao_jardins.id)

    expect(page).to_not have_content('Editar')
  end

end