require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário vê todas os veículos de sua transportadora registrados' do
  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Vehicle.create!(plate: 'STK7777', brand: 'Stark Enterprises', model: 'M-43',
                    manufacturing_year: '2010', capacity: 100_000, carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Veículos'

    expect(current_path).to eq users_backoffice_vehicles_path
    expect(page).to have_css 'h2', text: 'Veículos de Pirate Dispatch Organization'
    within('thead') do
      expect(page).to have_css 'th', text: 'Placa'
      expect(page).to have_css 'th', text: 'Marca'
      expect(page).to have_css 'th', text: 'Modelo'
      expect(page).to have_css 'th', text: 'Ano de Fabricação'
      expect(page).to have_css 'th', text: 'Capacidade'
    end

    within('tbody') do
      expect(page).to have_css 'td', text: 'BAT0403'
      expect(page).to have_css 'td', text: 'Wayne Enterprises'
      expect(page).to have_css 'td', text: 'Batmovel'
      expect(page).to have_css 'td', text: '2000'
      expect(page).to have_css 'td', text: '10000'

      expect(page).to have_css 'td', text: 'STK7777'
      expect(page).to have_css 'td', text: 'Stark Enterprises'
      expect(page).to have_css 'td', text: 'M-43'
      expect(page).to have_css 'td', text: '2010'
      expect(page).to have_css 'td', text: '100000'
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

  it 'e volta para a home do usuário' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Veículos'
    click_on 'Voltar'

    expect(current_path).to eq users_backoffice_welcome_index_path
  end
end
# rubocop:enable Metrics/BlockLength
