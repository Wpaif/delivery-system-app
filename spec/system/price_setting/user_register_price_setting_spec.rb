require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário registra configuração de preços' do
  it 'e vê o formulaŕio' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Configurações de preços'
    click_on 'Nova configuração'

    expect(page).to have_css 'h2', text: 'Nova configuração de preço'
    expect(page).to have_field 'Limite inferior', type: 'number'
    expect(page).to have_field 'Limite superior', type: 'number'
    expect(page).to have_field 'Valor por kilometro', type: 'number'
    expect(page).to have_css 'input[type="submit"]'
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Configurações de preços'
    click_on 'Nova configuração'

    fill_in 'Limite inferior', with: '0'
    fill_in 'Limite superior', with: '100'
    fill_in 'Valor por kilometro', with: '10'
    click_on 'Criar Configuração de Preço'

    expect(current_path).to eq users_backoffice_price_settings_path
    expect(page).not_to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Configuração de preço cadastrada com sucesso.'
  end

  it 'e não preenche os capos corretamente' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Configurações de preços'
    click_on 'Nova configuração'

    fill_in 'Limite inferior', with: ''
    fill_in 'Limite superior', with: ''
    fill_in 'Valor por kilometro', with: '10'
    click_on 'Criar Configuração de Preço'

    expect(page).to have_content 'Limite inferior não pode ficar em branco'
    expect(page).to have_content 'Limite superior não pode ficar em branco'
  end
end
# rubocop:enable Metrics/BlockLength
