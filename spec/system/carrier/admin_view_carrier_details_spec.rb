require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Administrador vê detalhes de uma transportadora' do
  it 'e vê sua página de detalhes' do
    # Arrage
    Admin.create!(email: 'admin@sistemadefretes.com.br', password: '123456')

    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    # Act
    visit admin_path
    within('form') do
      fill_in 'Email', with: 'admin@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Transportadoras'
    click_on 'Detalhes'

    # Assert
    expect(current_path).to eq admins_backoffice_carrier_path(Carrier.first)
    expect(page).to have_css 'h2', text: 'Pirate Dispatch Organization'
    within('dl') do
      expect(page).to have_css 'dt', text: 'Razão social:'
      expect(page).to have_css 'dd', text: "Buggy's Delivery"

      expect(page).to have_css 'dt', text: 'Domínio de email:'
      expect(page).to have_css 'dd', text: 'buggy.com'

      expect(page).to have_css 'dt', text: 'CNPJ:'
      expect(page).to have_css 'dd', text: '00.112.112/0001-39'

      expect(page).to have_css 'dt', text: 'Endereço de faturamento:'
      expect(page).to have_css 'dd', text: 'Karai Bari Island'

      expect(page).to have_css 'dt', text: 'Status:'
      expect(page).to have_css 'dd', text: 'Ativa'
    end
  end

  it 'e volta para a listagem' do
    # Arrage
    Admin.create!(email: 'admin@sistemadefretes.com.br', password: '123456')

    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    # Act
    visit admin_path
    within('form') do
      fill_in 'Email', with: 'admin@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end
    click_on 'Transportadoras'
    click_on 'Detalhes'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq admins_backoffice_carriers_path
  end
end
# rubocop:enable Metrics/BlockLength
