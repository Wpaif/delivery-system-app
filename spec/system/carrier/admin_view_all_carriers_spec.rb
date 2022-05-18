require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Adiministrador consutal as transportadoras' do
  it 'e as vê em uma tabela' do
    # Arrange
    Admin.create!(email: 'admin@admin.com', password: '123456')

    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Carrier.create!(brand_name: 'Carrara', corporate_name: 'Transportadora Carrara LTDA',
                    email_domain: 'carrara.com', registered_number: '10.117.111/7591-77',
                    billing_address: 'Rua N° 0', enable: true)
    # Act
    visit admin_path
    within('form') do
      fill_in 'Email', with: 'admin@admin.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Transportadoras'

    # Assert
    expect(page).to have_css 'h2', text: 'Transportadoras'
    within('table') do
      expect(page).to have_css 'th', text: 'Nome'
      expect(page).to have_css 'th', text: 'Razão Social'
      expect(page).to have_css 'th', text: 'Domínio'
      expect(page).to have_css 'th', text: 'CNPJ'
      expect(page).to have_css 'th', text: 'Endereço para faturamento'
      expect(page).to have_css 'th', text: 'Cadastrar'

      expect(page).to have_css 'td', text: 'Pirate Dispatch Organization'
      expect(page).to have_css 'td', text: "Buggy's Delivery"
      expect(page).to have_css 'td', text: 'buggy.com'
      expect(page).to have_css 'td', text: '00.112.112/0001-39'
      expect(page).to have_css 'td', text: 'Karai Bari Island'
      expect(page).to have_css 'td', text: 'Detalhes'

      expect(page).to have_css 'td', text: 'Carrara'
      expect(page).to have_css 'td', text: 'Transportadora Carrara LTDA'
      expect(page).to have_css 'td', text: 'carrara.com'
      expect(page).to have_css 'td', text: '10.117.111/7591-77'
      expect(page).to have_css 'td', text: 'Rua N° 0'
      expect(page).to have_css 'td', text: 'Detalhes'
    end
  end

  it 'mas não há nenhuma cadastrada' do
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

    # Assert
    expect(page).not_to have_css 'table'
    expect(page).to have_css 'div', text: 'Não há transportadoras cadastradas.'
  end
end
# rubocop:enable Metrics/BlockLength
