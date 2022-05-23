require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Deadline, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando o limite inferior não é informado' do
        carrier = Carrier.create!(brand_name: 'Pirate Dispatch Organization',
                                  corporate_name: "Buggy's Delivery", email_domain: 'buggy.com',
                                  registered_number: '00.112.112/0001-39',
                                  billing_address: 'Karai Bari Island', enable: true)

        User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: carrier.id)

        setting = Deadline.new(lower_limit: '', upper_limit: 100, days: 10, carrier_id: carrier.id)

        expect(setting.valid?).to eq false
      end

      it 'inválido quando o limite superior não é informado' do
        carrier = Carrier.create!(brand_name: 'Pirate Dispatch Organization',
                                  corporate_name: "Buggy's Delivery", email_domain: 'buggy.com',
                                  registered_number: '00.112.112/0001-39',
                                  billing_address: 'Karai Bari Island', enable: true)

        User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: carrier.id)

        setting = Deadline.new(lower_limit: 0, upper_limit: '', days: 10, carrier_id: carrier.id)

        expect(setting.valid?).to eq false
      end

      it 'inválido quando o dias não é informado' do
        carrier = Carrier.create!(brand_name: 'Pirate Dispatch Organization',
                                  corporate_name: "Buggy's Delivery", email_domain: 'buggy.com',
                                  registered_number: '00.112.112/0001-39',
                                  billing_address: 'Karai Bari Island', enable: true)

        User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: carrier.id)

        setting = Deadline.new(lower_limit: 0, upper_limit: 100, days: '', carrier_id: carrier.id)

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

      range = Deadline.create(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: carrier.id).range

      valid = range == Range.new(Deadline.last.lower_limit, Deadline.last.upper_limit)

      expect(valid).to eq true
    end
  end
end
# rubocop:enable Metrics/BlockLength
