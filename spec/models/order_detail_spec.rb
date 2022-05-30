require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe PriceSetting, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando a cidade não é informada' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                        manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

        Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
        Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

        PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
        PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

        Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                      city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                      carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

        order_detail = OrderDetail.new(city: '', order_id: Order.first.id)

        expect(order_detail.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'inválido quando o produto já passou pela cidade informada' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                        manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

        Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
        Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

        PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
        PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

        Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                      city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                      carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

        OrderDetail.create!(city: 'Orange Town', order_id: Order.first.id)

        order_detail = OrderDetail.new(city: 'Orange Town', order_id: Order.first.id)

        expect(order_detail.valid?).to eq false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
