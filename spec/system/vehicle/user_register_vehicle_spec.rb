require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário registra um veículo' do
  it 'e vê o formulário' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit new_users_backoffice_vehicle_path

    expect(current_path).to eq new_users_backoffice_vehicle_path
    expect(page).to have_css 'h2', text: 'Cadastro de novo veículo'

    expect(page).to have_field 'Placa', type: 'text'
    expect(page).to have_field 'Marca', type: 'text'
    expect(page).to have_field 'Modelo', type: 'text'
    expect(page).to have_field 'Ano de Fabricação', type: 'number'
    expect(page).to have_field 'Capacidade', type: 'number'
    expect(page).to have_css 'input[type="submit"]'
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit new_users_backoffice_vehicle_path

    fill_in 'Placa', with: 'BAT4303'
    fill_in 'Marca', with: 'Wayne Enterprises'
    fill_in 'Modelo', with: 'Batmovel'
    fill_in 'Ano de Fabricação', with: '2000'
    fill_in 'Capacidade', with: '100000'
    click_on 'Criar Veículo'

    expect(current_path).to eq users_backoffice_vehicle_path(Vehicle.first)
  end

  it 'e não preenche todos campos' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    user = User.create!(email: 'Wilian@buggy.com', password: '123456', carrier_id: Carrier.first.id)

    login_as(user)
    visit new_users_backoffice_vehicle_path

    fill_in 'Placa', with: 'BAT4303'
    fill_in 'Marca', with: 'Wayne Enterprises'
    fill_in 'Modelo', with: 'Batmovel'
    click_on 'Criar Veículo'

    expect(page).to have_content 'Ano de Fabricação não pode ficar em branco '
    expect(page).to have_content 'Capacidade não pode ficar em branco'
  end
end
# rubocop:enable Metrics/BlockLength
