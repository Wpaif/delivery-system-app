require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário vê o log de consultas' do
  it 'com sucesso' do
    Carrier.create!(brand_name: 'Carrara', corporate_name: 'Transportadora Carrara LTDA',
                    email_domain: 'carrara.com', registered_number: '10.117.111/7591-77',
                    billing_address: 'Rua N° 0', enable: true)

    PriceSetting.create!(lower_limit: 0, upper_limit: 100, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(lower_limit: 101, upper_limit: 1000, value: 15, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 25, carrier_id: Carrier.first.id)

    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    SearchHistory.create!(value: 1000, estimated_delivery_date: Date.parse('2022-06-10'),
                          admin_id: Admin.first.id)

    SearchHistory.create!(value: 2000, estimated_delivery_date: Date.parse('2022-06-11'),
                          admin_id: Admin.first.id)
    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Consultar valores'
    click_on 'Histórico de Pesquisas'
    expect(current_path).to eq admins_backoffice_query_history_index_path
    expect(page).to have_css 'h2', text: 'Histórico de pesquisas'
    expect(page).to have_content 'Valor: 1000 Data estimada para entrega: 10 de junho de 2022'
    expect(page).to have_content 'Valor: 2000 Data estimada para entrega: 11 de junho de 2022'
    expect(page).to have_link 'Voltar'
  end
end
# rubocop:enable Metrics/BlockLength
