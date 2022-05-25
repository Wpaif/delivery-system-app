require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Administrador faz consulta de valores' do
  it 'e vê o formulário para tal' do
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

    click_on 'Consultar valores'

    expect(current_path).to eq admins_backoffice_budgets_path

    expect(page).to have_field 'Transportadora'
    expect(page).to have_field 'Distância até a transportadora'
    expect(page).to have_field 'Peso'
    expect(page).to have_button 'Consultar'
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Carrara', corporate_name: 'Transportadora Carrara LTDA',
                    email_domain: 'carrara.com', registered_number: '10.117.111/7591-77',
                    billing_address: 'Rua N° 0', enable: true)

    PriceSetting.create!(lower_limit: 0, upper_limit: 100, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(lower_limit: 101, upper_limit: 1000, value: 15, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 15, carrier_id: Carrier.first.id)

    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Consultar valores'

    select 'Carrara', from: 'Transportadora'
    fill_in 'Distância até a transportadora', with: '100'
    fill_in 'Peso', with: '100'
    click_on 'Consultar'

    expect(current_path).to eq admins_backoffice_budget_result_path
    expect(page).to have_content 'Valor: R$ 1.000,00'
    expect(page).to have_content "Previsão de entrega: #{I18n.l(Deadline.first.days.day.from_now, format: :short)}"
  end

  it 'e não fornece dados incompletos' do
    Carrier.create!(brand_name: 'Carrara', corporate_name: 'Transportadora Carrara LTDA',
                    email_domain: 'carrara.com', registered_number: '10.117.111/7591-77',
                    billing_address: 'Rua N° 0', enable: true)

    PriceSetting.create!(lower_limit: 0, upper_limit: 100, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(lower_limit: 101, upper_limit: 1000, value: 15, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 15, carrier_id: Carrier.first.id)

    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Consultar valores'

    fill_in 'Distância até a transportadora', with: ''
    fill_in 'Peso', with: '1'
    click_on 'Consultar'

    expect(page).to have_content 'Dados inválidos.'
  end

  it 'e fornece dados que não abranje o ranges de deadlines e price_settings' do
    Carrier.create!(brand_name: 'Carrara', corporate_name: 'Transportadora Carrara LTDA',
                    email_domain: 'carrara.com', registered_number: '10.117.111/7591-77',
                    billing_address: 'Rua N° 0', enable: true)

    PriceSetting.create!(lower_limit: 0, upper_limit: 100, value: 10, carrier_id: Carrier.first.id)
    PriceSetting.create!(lower_limit: 101, upper_limit: 1000, value: 15, carrier_id: Carrier.first.id)

    Deadline.create!(lower_limit: 0, upper_limit: 100, days: 10, carrier_id: Carrier.first.id)
    Deadline.create!(lower_limit: 101, upper_limit: 1000, days: 15, carrier_id: Carrier.first.id)

    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Consultar valores'

    fill_in 'Distância até a transportadora', with: '10000'
    fill_in 'Peso', with: '10000'
    click_on 'Consultar'

    expect(page).to have_content 'O valores informados não são atendidos por essa transportadora.'
  end
end
# rubocop:enable Metrics/BlockLength
