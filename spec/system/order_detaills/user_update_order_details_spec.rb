require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário artualiza os detalhes de uma ordem de serviço' do
  it 'e chega no formulário para tal' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                  city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                  carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

    user = User.create!(email: 'wilian@buggy.com', password: '123456')

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Ordens de Serviços'
    click_on 'Ver detalhes'

    click_on 'Atualizar Status'

    expect(current_path).to eq new_users_backoffice_order_detail_path
    expect(page).to have_css 'h2', text: 'Atualização da order de serviço'
    expect(page).to have_field 'Cidade', type: 'text'
    expect(page).to have_button 'Atualizar'
  end

  it 'com sucesso, mas ainda não está no destino' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                  city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                  carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

    user = User.create!(email: 'wilian@buggy.com', password: '123456')

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Ordens de Serviços'
    click_on 'Ver detalhes'

    click_on 'Atualizar Status'

    fill_in 'Cidade', with: 'Orange Town'
    click_on 'Atualizar'

    expect(current_path).to eq users_backoffice_order_path(Order.first)
    expect(page).to have_content 'Status da ordem de serviço atualizado com sucesso'
    expect(page).to have_content 'Status: Em transporte'
  end

  it 'com sucesso estando no destino' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                  city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                  carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

    user = User.create!(email: 'wilian@buggy.com', password: '123456')

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Ordens de Serviços'
    click_on 'Ver detalhes'

    click_on 'Atualizar Status'

    fill_in 'Cidade', with: 'Vila Foosha'
    click_on 'Atualizar'

    expect(current_path).to eq users_backoffice_order_path(Order.first)
    expect(page).to have_content 'Status da ordem de serviço atualizado com sucesso'
    expect(page).to have_content 'Status: Entregue'
  end

  it 'sem informar por qual cidade passou' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                  city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                  carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

    user = User.create!(email: 'wilian@buggy.com', password: '123456')

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Ordens de Serviços'
    click_on 'Ver detalhes'

    click_on 'Atualizar Status'

    fill_in 'Cidade', with: ''
    click_on 'Atualizar'

    expect(page).to have_content 'Não foi possível atualizar o status da ordem de serviço'
    expect(page).to have_css 'p', text: 'Verifique os erros abaixo:'
    expect(page).to have_css 'li', text: 'Cidade não pode ficar em branco'
  end

  it 'informando uma cidade por qual já passou' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(upper_limit: 1000, lower_limit: 101, value: 15, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                  city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                  carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

    OrderDetail.create!(city: 'Orange Town', order_id: Order.last.id)

    user = User.create!(email: 'wilian@buggy.com', password: '123456')

    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Ordens de Serviços'
    click_on 'Ver detalhes'

    click_on 'Atualizar Status'

    fill_in 'Cidade', with: 'Orange Town'
    click_on 'Atualizar'

    expect(page).to have_content 'Não foi possível atualizar o status da ordem de serviço'
    expect(page).to have_css 'p', text: 'Verifique os erros abaixo:'
    expect(page).to have_css 'li', text: 'A encomenda já passou pela cidade informada'
  end
end
# rubocop:enable Metrics/BlockLength
