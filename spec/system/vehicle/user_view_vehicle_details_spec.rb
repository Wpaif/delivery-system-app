require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário vê detalhes de um veículo' do
  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Veículos'
    click_on 'Detalhes'

    expect(current_path).to eq users_backoffice_vehicle_path(Vehicle.first)
    expect(page).to have_css 'h2', text: 'Batmovel - BAT0403'
    within('dl') do
      expect(page).to have_css 'dt', text: 'Marca:'
      expect(page).to have_css 'dd', text: 'Wayne Enterprises'

      expect(page).to have_css 'dt', text: 'Ano de Fabricação'
      expect(page).to have_css 'dd', text: '2000'

      expect(page).to have_css 'dt', text: 'Capacidade'
      expect(page).to have_css 'dd', text: '10000'
    end
  end

  it 'e volta para a listagem de veículos' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Veículos'
    click_on 'Detalhes'

    click_on 'Voltar'

    expect(current_path).to eq users_backoffice_vehicles_path
  end
end
# rubocop:enable Metrics/BlockLength
