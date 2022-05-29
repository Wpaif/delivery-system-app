require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Order, type: :model do
  it 'gera um código aleatório' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Wilson P Ferreira', distance: 100, postal_code: '12345-000', city: 'Unaí',
                  street: 'Avenida do comércio', number: 10, weight: 1000, vehicle_id: Vehicle.last,
                  carrier_id: Carrier.first.id)

    result = Order.first.code

    expect(result).not_to be_empty
    expect(result.length).to eq 15
  end

  it 'gera um código único' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Wilson P Ferreira', distance: 100, postal_code: '12345-000', city: 'Unaí',
                  street: 'Avenida do comércio', number: 10, weight: 1000, vehicle_id: Vehicle.last,
                  carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '98765-000',
                  city: 'Orange Town', street: 'Rua da goma', number: 21, weight: 1000,
                  vehicle_id: Vehicle.last, carrier_id: Carrier.first.id)

    first_code = Order.first.code
    second_code = Order.last.code

    expect(first_code != second_code).to eq true
  end
end
# rubocop:enable Metrics/BlockLength
