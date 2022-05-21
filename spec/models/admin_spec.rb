require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'inválido quando email do admin não tem o domínio "sistemadefrete.com.br"' do
        admin = Admin.new(email: 'admin@gmail.com', password: '123456')

        expect(admin.valid?).to eq false
      end
    end
  end
end
