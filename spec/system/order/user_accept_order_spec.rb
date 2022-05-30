require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário aceita ordem de serviço' do
  it 'e vê o botão de para tal' do
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
    click_on 'Ver detalhes'

    expect(current_path).to eq users_backoffice_order_path(Order.first.id)
    expect(page).to have_css 'h2', text: 'Ordem de serviço'
    expect(page).to have_content 'Destinatário: Monkey D. Luffy'
    expect(page).to have_content 'CEP: 12345-000'
    expect(page).to have_content 'Cidade: Vila Foosha'
    expect(page).to have_content 'Rua: Meat Street'
    expect(page).to have_content 'Número: 10'
    expect(page).to have_content 'Peso: 1000Kg'
    expect(page).to have_content 'Distância: 100Km'
    expect(page).to have_content 'Valor: R$ 10.000,00'
    expect(page).to have_content 'Status: Pendente de aceitação'
    expect(page).not_to have_content 'Data estimada para entrega:'

    expect(page).to have_link 'Aceitar'
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)
    Vehicle.create!(plate: 'STK7777', brand: 'Stark Enterprises', model: 'M-43',
                    manufacturing_year: '2010', capacity: 100_000, carrier_id: Carrier.first.id)

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
    click_on 'Ver detalhes'

    click_on 'Aceitar'

    select 'M-43', from: 'Veículo'
    click_on 'Aceitar'

    expect(current_path).to eq users_backoffice_order_path(Order.first.id)
    expect(page).to have_content 'Ordem de serviço aceita com sucesso'
    expect(page).to have_content 'Data estimada para entrega:'
  end
end
# rubocop:enable Metrics/BlockLength
