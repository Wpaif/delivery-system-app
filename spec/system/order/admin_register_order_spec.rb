require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Adiministrador registra um pedido' do
  it 'E vê o formulário para tal' do
    Carrier.create!(brand_name: 'Carrara', corporate_name: 'Transportadora Carrara LTDA',
                    email_domain: 'carrara.com', registered_number: '10.117.111/7591-77',
                    billing_address: 'Rua N° 0', enable: true)

    PriceSetting.create!(lower_limit: 0, upper_limit: 100, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(lower_limit: 101, upper_limit: 1000, value: 15, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Nova ordem de serviço'

    expect(current_path).to eq new_admins_backoffice_order_path
    expect(page).to have_css 'h2', text: 'Cadastro de ordem de serviço'
    expect(page).to have_field 'Destinatário'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Rua'
    expect(page).to have_field 'Número'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Distância'
    expect(page).to have_css 'input[type="submit"]'
  end
end
# rubocop:enable Metrics/BlockLength
