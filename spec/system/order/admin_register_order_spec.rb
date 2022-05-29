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
    expect(page).to have_field 'Transportadora'
    expect(page).to have_css 'input[type="submit"]'
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

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

    fill_in 'Destinatário', with: 'Monkey D. Luffy'
    fill_in 'CEP', with: '90990-000'
    fill_in 'Cidade', with: 'Vila Foosha'
    fill_in 'Rua', with: 'Meat Street'
    fill_in 'Número', with: '0'
    fill_in 'Peso', with: '100'
    fill_in 'Distância', with: '1000'
    select 'Pirate Dispatch Organization', from: 'Transportadora'
    click_on 'Criar Ordem de Serviço'

    expect(current_path).to eq admins_backoffice_order_path(Order.first)
    expect(page).to have_css 'h2', text: "Ordem de serviço <#{Order.first.code}>"
    expect(page).to have_content 'Destinatário: Monkey D. Luffy'
    expect(page).to have_content 'CEP: 90990-000'
    expect(page).to have_content 'Cidade: Vila Foosha'
    expect(page).to have_content 'Rua: Meat Street'
    expect(page).to have_content 'Número: 0'
    expect(page).to have_content 'Peso: 100Kg'
    expect(page).to have_content 'Distância: 1000Km'
  end

  it 'Com dados inválidos' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

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

    fill_in 'Destinatário', with: 'Monkey D. Luffy'
    fill_in 'CEP', with: '9099-000'
    fill_in 'Cidade', with: 'Vila Foosha'
    fill_in 'Rua', with: 'Meat Street'
    fill_in 'Número', with: '0'
    fill_in 'Peso', with: '100'
    select 'Pirate Dispatch Organization', from: 'Transportadora'
    click_on 'Criar Ordem de Serviço'

    expect(page).to have_content 'Distância não pode ficar em branco'
    expect(page).to have_content 'CEP não é válido'
  end
end
# rubocop:enable Metrics/BlockLength
