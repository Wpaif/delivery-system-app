require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe PriceSetting, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando o limite inferior não é informado' do
        carrier = Carrier.create!(brand_name: 'Pirate Dispatch Organization',
                                  corporate_name: "Buggy's Delivery", email_domain: 'buggy.com',
                                  registered_number: '00.112.112/0001-39',
                                  billing_address: 'Karai Bari Island', enable: true)

        User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: carrier.id)

        setting = PriceSetting.new(lower_limit: '', upper_limit: 100,
                                   value: 10, carrier_id: carrier.id)

        expect(setting.valid?).to eq false
      end

      it 'inválido quando o limite superior não é informado' do
        carrier = Carrier.create!(brand_name: 'Pirate Dispatch Organization',
                                  corporate_name: "Buggy's Delivery", email_domain: 'buggy.com',
                                  registered_number: '00.112.112/0001-39',
                                  billing_address: 'Karai Bari Island', enable: true)

        User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: carrier.id)

        setting = PriceSetting.new(lower_limit: 0, upper_limit: '',
                                   value: 10, carrier_id: carrier.id)

        expect(setting.valid?).to eq false
      end

      it 'inválido quando o valor por kilometro não é informado' do
        carrier = Carrier.create!(brand_name: 'Pirate Dispatch Organization',
                                  corporate_name: "Buggy's Delivery", email_domain: 'buggy.com',
                                  registered_number: '00.112.112/0001-39',
                                  billing_address: 'Karai Bari Island', enable: true)

        User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: carrier.id)

        setting = PriceSetting.new(lower_limit: 0, upper_limit: 100,
                                   value: '', carrier_id: carrier.id)

        expect(setting.valid?).to eq false
      end
    end
  end

  describe '.range' do
    it 'é gerado o range' do
      carrier = Carrier.create!(brand_name: 'Pirate Dispatch Organization',
                                corporate_name: "Buggy's Delivery", email_domain: 'buggy.com',
                                registered_number: '00.112.112/0001-39',
                                billing_address: 'Karai Bari Island', enable: true)

      User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: carrier.id)

      range = PriceSetting.create(lower_limit: 0, upper_limit: 100, value: 10, carrier_id: carrier.id)
                          .range

      valid = range == Range.new(PriceSetting.last.lower_limit, PriceSetting.last.upper_limit)

      expect(valid).to eq true
    end
  end
end
# rubocop:enable Metrics/BlockLength
