require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário faz login no sistema' do
  it 'e vê o fomulário para isso' do
    visit root_path
    click_on 'Entrar'

    expect(current_path).to eq new_user_session_path
    within('form') do
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
    end
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    User.create!(email: 'user@buggy.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'user@buggy.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(current_path).to eq user_root_path
  end

  it 'e não fornece os dados corretamente' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    User.create!(email: 'user@buggy.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail',	with: ''
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    expect(page).to have_content 'E-mail ou senha inválidos.'
  end
end
# rubocop:enable Metrics/BlockLength
