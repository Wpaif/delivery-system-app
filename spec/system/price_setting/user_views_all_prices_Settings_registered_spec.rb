require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário vê todas as configurações de preços' do
  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Configurações de preços'

    expect(page).to have_css 'h2', text: 'Configurações de preços por kilometro'
    within('dl') do
      expect(page).to have_content 'De 0Kg - 100Kg: R$: 10.0'
      expect(page).to have_content 'De 101Kg - 1000Kg: R$: 15.0'
    end

    expect(page).to have_css 'a', text: 'Voltar'
  end

  it 'e não há nenhuma configuração de preço registrada' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)
    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Configurações de preços'
    
    expect(page).to have_content 'Não há configurações de preços registradas'
  end
end
# rubocop:enable Metrics/BlockLength
