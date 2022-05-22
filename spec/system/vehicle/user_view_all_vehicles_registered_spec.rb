require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário vê todas os veículos de sua transportadora registrados' do
  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturin_year: '2000-04-14', capacity: 10_000, carrier_id: Carrier.first.id)

    Vehicle.create!(plate: 'STK7777', brand: 'Stark Enterprises', model: 'M-43',
                    manufacturin_year: '2010-10-08', capacity: 100_000, carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Veículos'

    expect(current_path).to eq users_backoffice_vehicles_path
    expect(page).to have_css 'h2', text: 'Veículos de Pirate Dispatch Organization'
    within('thead tr') do
      expect(page).to have_css 'th', text: 'Placa'
      expect(page).to have_css 'th', text: 'Marca'
      expect(page).to have_css 'th', text: 'Modelo'
      expect(page).to have_css 'th', text: 'Ano de Fabricação'
      expect(page).to have_css 'th', text: 'Capacidade'
    end
  end

  it 'e não há veículos cadastrados' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Veículos'

    expect(current_path).to eq users_backoffice_vehicles_path
    expect(page).to have_css 'h2', text: 'Veículos de Pirate Dispatch Organization'
    expect(page).to have_css 'p', text: 'Não há veículos registrados'
  end
end
# rubocop:enable Metrics/BlockLength
