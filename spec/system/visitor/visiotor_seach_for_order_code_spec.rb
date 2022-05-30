require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Visitante acessa a aplicação para consultar o código de uma ordem de serviço' do
  it 'e vê o formulário para tal' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                  city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                  carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

    visit root_path
    expect(page).to have_css 'h2', text: 'Consulte um pedido'
    expect(page).to have_field 'Código', type: 'text'
    expect(page).to have_button 'Ver detalhes'
  end

  it 'e vê os detalhes do pedido' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Vehicle.create!(plate: 'BAT0403', brand: 'Wayne Enterprises', model: 'Batmovel',
                    manufacturing_year: '2000', capacity: 10_000, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)

    PriceSetting.create!(upper_limit: 100, lower_limit: 0, value: 10, carrier_id: Carrier.first.id)

    Order.create!(recipient: 'Monkey D. Luffy', distance: 100, postal_code: '12345-000',
                  city: 'Vila Foosha', street: 'Meat Street', number: 10, weight: 1000,
                  carrier_id: Carrier.first.id, vehicle_id: Vehicle.first, status: :on_carriage)

    OrderDetail.create!(city: 'Orange Town', order_id: Order.first.id)
    OrderDetail.create!(city: 'Vila Foosha', order_id: Order.first.id)

    visit root_path
    fill_in 'Código', with: Order.first.code
    click_on 'Ver detalhes'

    expect(page).to have_css 'h2', text: "Detalhes do pedido <#{OrderDetail.first.order.code}>"
    expect(page).to have_css 'h3', text: 'Destinatário: Monkey D. Luffy'
    within('dl') do
      expect(page).to have_content 'Passou por:'
      expect(page).to have_content 'Em:'
      expect(page).to have_content 'Vila Foosha'
      expect(page).to have_content 'Orange Town'
    end
    expect(page).to have_link 'Voltar'
  end

  it 'e digita um código inválido' do
    visit root_path
    fill_in 'Código', with: ''
    click_on 'Ver detalhes'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Código inválido'
  end
end
# rubocop:enable Metrics/BlockLength
