require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'usuário vê todos os intervalos de prazos cadastrados' do
  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 200, days: 17, carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Prazos'

    expect(page).to have_css 'h2', text: 'Prazos registrados'
    within('dl') do
      expect(page).to have_content 'De 0Km - 100Km: 10 dias'
      expect(page).to have_content 'De 101Km - 200Km: 17 dias'
    end

    expect(page).to have_css 'a', text: 'Voltar'
  end

  it 'e não há prazos cadastrados' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Prazos'

    expect(page).to have_content 'Não há prazos cadastrados.'
  end
end
# rubocop:enable Metrics/BlockLength
