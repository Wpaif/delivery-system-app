require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Administrador registra uma transportadora' do
  it 'e vê o formulário' do
    # Arrange
    Admin.create!(email: 'admin@admin.com', password: '123456')

    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    # Act
    visit admin_path
    within('form') do
      fill_in 'Email', with: 'admin@admin.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Transportadoras'
    click_on 'Cadastrar'

    # Assert
    expect(current_path).to eq new_admins_backoffice_carrier_path
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'Domínio de email'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço de faturamento'
    expect(page).to have_css 'input[type="submit"]'
  end

  it "com sucesso" do
    # Arrange
    Admin.create!(email: 'admin@admin.com', password: '123456')

    # Act
    visit admin_path
    within('form') do
      fill_in 'Email', with: 'admin@admin.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Transportadoras'
    click_on 'Cadastrar'

    fill_in 'Nome', with: 'Pirate Dispatch Organization'
    fill_in 'Razão social', with: "Buggy's Delivery"
    fill_in 'Domínio de email', with: 'buggy.com'
    fill_in 'CNPJ', with: '00.112.112/0001-39'
    fill_in 'Endereço de faturamento', with: 'Karai Bari Island'
    click_on 'Criar Transportadora'

    # Assert
    expect(page).to have_css 'p', text: 'Transportadora registrada com sucesso.'
  end
end
# rubocop:enable Metrics/BlockLength
