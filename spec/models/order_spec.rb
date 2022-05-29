require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Order, type: :model do
  describe '.genarate_code' do
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

  describe '#valid?' do
    context 'presence' do
      it 'inválido quando status não é atribuído' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-999',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        result = order.status && true

        expect(result).to eq true
      end

      it 'inválido quando destinatário não é informado' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: '', distance: 100, postal_code: '12345-999',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando a distância não é informada' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: '', postal_code: '12345-999',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando o CEP não é informado' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando a cidade não é informada' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-678',
                          city: '', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando a rua não é informada' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-678',
                          city: 'Vila Foosha', street: '', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando o número não é informado' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-678',
                          city: 'Vila Foosha', street: 'Meat Street', number: '', weight: 100,
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando o peso não é informado' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-678',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: '',
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando a transportadora não é informada' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-678',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: '')

        expect(order.valid?).to eq false
      end
    end

    context 'format' do
      it 'inválido quando o cep é informado errado' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '1234-999',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        expect(order.valid?).to eq false
      end

      it 'inválido quando o código é ferado de forma errada' do
        Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                        email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                        billing_address: 'Karai Bari Island', enable: true)

        order = Order.new(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '1234-999',
                          city: 'Vila Foosha', street: 'Meat Street', number: 0, weight: 100,
                          carrier_id: Carrier.first.id)

        order.code = 'adfa123[]??!!'

        expect(order.valid?).to eq false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
