require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando a placa não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: '', brand: 'Wayne Enterprises', model: 'Batmovel',
                              manufacturin_year: '2000-04-14', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a marca não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: '', model: 'Batmovel',
                              manufacturin_year: '2000-04-14', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a modelo não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: 'Wayne Enterprises', model: '',
                              manufacturin_year: '2000-04-14', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a data de frabricação não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: 'Wayne Enterprises', model: 'Batmovel',
                              manufacturin_year: '', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a capacidade não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: 'Wayne Enterprises', model: 'Batmovel',
                              manufacturin_year: '2000-04-14', capacity: '', carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end
    end

    context 'format' do
      it 'inválido quando o formato da paca não segue os padrão antigo ou o da mercorsul' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'STK00A3', brand: 'Stark Enterprises', model: 'M-43',
                              manufacturin_year: '2010-10-08', capacity: 100_000,
                              carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end
    end

    context 'comparison' do
      it 'inválido quando a data de fabricação informada está no futuro' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'STK00A3', brand: 'Stark Enterprises', model: 'M-43',
                              manufacturin_year: '5000-10-08', capacity: 100_000,
                              carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
