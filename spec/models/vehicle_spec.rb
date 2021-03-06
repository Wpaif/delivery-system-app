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
                              manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a marca não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: '', model: 'Batmovel',
                              manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a modelo não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: 'Wayne Enterprises', model: '',
                              manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a data de frabricação não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: 'Wayne Enterprises', model: 'Batmovel',
                              manufacturing_year: '', capacity: 10_000, carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end

      it 'inválido quando a capacidade não é informada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'BAT3001', brand: 'Wayne Enterprises', model: 'Batmovel',
                              manufacturing_year: '2000', capacity: '', carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end
    end

    context 'format' do
      it 'inválido quando o formato da paca não segue os padrão antigo ou o da mercorsul' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        vehicle = Vehicle.new(plate: 'STK00A3', brand: 'Stark Enterprises', model: 'M-43',
                              manufacturing_year: '2010', capacity: 100_000,
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
                              manufacturing_year: '5000', capacity: 100_000,
                              carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'inválido uma placa já foi cadastrada' do
        Carrier.create(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                       email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                       billing_address: 'Karai Bari Island', enable: true)

        Vehicle.create(plate: 'STK00A3', brand: 'Stark Enterprises', model: 'M-43',
                       manufacturing_year: '2022', capacity: 100_000, carrier_id: Carrier.first.id)

        vehicle = Vehicle.new(plate: 'STK00A3', brand: 'Wayne Enterprises', model: 'Batmovel',
                              manufacturing_year: '2000', capacity: 200_000,
                              carrier_id: Carrier.first.id)

        expect(vehicle.valid?).to eq false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
