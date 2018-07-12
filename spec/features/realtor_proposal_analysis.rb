require 'rails_helper' 

feature 'show proposal' do
  scenario 'successfully' do
    

    property_type = PropertyType.create(name: 'Apartamento')
    proposal = Proposal.create(guest_name: 'teste',
                              email: 'teste@teste.com',                          
                              start_date: '10-10-2007',
                              end_date: '15-10-2017',
                              total_guests: 20,
                              pet: true, 
                              total_amount: 20)




    
  end
end