require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário vê todas as ordens de serviço de sua transportadora' do
  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000', city: 'Vila Foosha',
                  street: 'Meat Street', number: 10, weight: 1000, carrier_id: Carrier.first.id)

    user = User.create!(email: 'wilian@buggy.com', password: '123456')

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Ordens de Serviços'

    expect(current_path).to eq users_backoffice_orders_path
    expect(page).to have_css 'h2', text: 'Ordens de Serviço'
    within('table') do
      expect(page).to have_css 'th', text: 'Para'
      expect(page).to have_css 'th', text: 'Cidade'
      expect(page).to have_css 'th', text: 'Distância'
      expect(page).to have_css 'th', text: 'Status'
      expect(page).to have_css 'th', text: 'Ações'

      expect(page).to have_css 'td', text: 'Monkey D. Luffy'
      expect(page).to have_css 'td', text: 'Vila Foosha'
      expect(page).to have_css 'td', text: '100 Km'
      expect(page).to have_css 'td a', text: 'Ver detalhes'
    end
    expect(page).to have_link 'Voltar'
  end

  it 'e não a ordens de serviço cadastradas' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'wilian@buggy.com', password: '123456')

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Ordens de Serviços'

    expect(page).to have_content 'Não há ordens de serviços'
  end
end
# rubocop:enable Metrics/BlockLength
