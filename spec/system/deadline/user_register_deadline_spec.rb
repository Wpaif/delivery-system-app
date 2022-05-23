require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário registra um prazo' do
  it 'e vê o formulário' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Prazos'
    click_on 'Novo prazo'

    expect(current_path).to eq new_users_backoffice_deadline_path
    expect(page).to have_css 'h2', text: 'Novo prazo'
    expect(page).to have_field 'Limite inferior', type: 'number'
    expect(page).to have_field 'Limite superior', type: 'number'
    expect(page).to have_field 'Dias para entrega', type: 'number'
    expect(page).to have_css 'input[type="submit"]'
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Prazos'
    click_on 'Novo prazo'

    fill_in 'Limite inferior',	with: '0'
    fill_in 'Limite superior',	with: '100'
    fill_in 'Dias para entrega',	with: '10'
    click_on 'Criar Prazo'

    expect(current_path).to eq users_backoffice_deadlines_path
    expect(page).not_to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Prazo cadastrado com sucesso.'
  end

  it 'e não preenche os campos corretamente' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Prazos'
    click_on 'Novo prazo'

    fill_in 'Limite inferior',	with: ''
    fill_in 'Limite superior',	with: '100'
    fill_in 'Dias para entrega',	with: '10'
    click_on 'Criar Prazo'

    expect(page).to have_content 'Limite inferior não pode ficar em branco'
  end
end
# rubocop:enable Metrics/BlockLength
