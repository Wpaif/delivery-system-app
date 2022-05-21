require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Carrier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando nome está vazio' do
        carrier = Carrier.new(brand_name: '', corporate_name: "Buggy's Delivery",
                              email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                              billing_address: 'Karai Bari Island', enable: true)

        expect(carrier.valid?).to eq false
      end

      it 'inválido quando razão social está vazio' do
        carrier = Carrier.new(brand_name: 'Pirate Dispatch Organization', corporate_name: '',
                              email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                              billing_address: 'Karai Bari Island', enable: true)

        expect(carrier.valid?).to eq false
      end

      it 'inválido quando endereço de email está vazio' do
        carrier = Carrier.new(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                              email_domain: '', registered_number: '00.112.112/0001-39',
                              billing_address: 'Karai Bari Island', enable: true)

        expect(carrier.valid?).to eq false
      end

      it 'inválido quando CNPJ está vazio' do
        carrier = Carrier.new(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                              email_domain: 'buggy.com', registered_number: '',
                              billing_address: 'Karai Bari Island', enable: true)

        expect(carrier.valid?).to eq false
      end

      it 'inválido quando endereço de faturamento está vazio' do
        carrier = Carrier.new(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                              email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                              billing_address: '', enable: true)

        expect(carrier.valid?).to eq false
      end
    end

    context 'format' do
      it 'inválido quando CNPJ não atende ao formato correto' do
        carrier = Carrier.new(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                              email_domain: 'buggy.com', registered_number: '00112112/0001-39',
                              billing_address: 'Karai Bari Island', enable: true)

        expect(carrier.valid?).to eq false
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
