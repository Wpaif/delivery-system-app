require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário desabilita transportadora' do
  it 'e vê botão para tal' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Transportadoras'
    click_on 'Detalhes'

    expect(page).to have_button 'Desativa transportadora'
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Transportadoras'
    click_on 'Detalhes'

    click_on 'Desativa transportadora'

    expect(current_path).to eq admins_backoffice_carrier_path(Carrier.first.id)
    expect(page).to have_content 'Transportadora desativada com sucesso'
  end
end
# rubocop:enable Metrics/BlockLength
