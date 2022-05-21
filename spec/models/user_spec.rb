require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'invalido quando o domínio do email não pertence a nenhuma transportadora' do
      Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                      email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                      billing_address: 'Karai Bari Island', enable: true)

      user = User.new(email: 'wilian@gmail.com', password: '123456')

      expect(user.valid?).to eq false
    end
  end
end
