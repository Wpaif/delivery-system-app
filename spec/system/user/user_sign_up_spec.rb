require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Usuário se cadastra' do
  it 'e vê o fomulário' do
    visit root_path
    click_on 'Cadastrar-se'

    expect(current_path).to eq new_user_registration_path
    expect(page).to have_content 'Cadastro de usuários'
    within('form') do
      expect(page).to have_field 'E-mail'
      expect(page).to have_field 'Senha'
      expect(page).to have_field 'Confirme sua senha'
      expect(page).to have_button 'Cadastrar'
    end
  end

  it 'com sucesso' do
    Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
                    email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
                    billing_address: 'Karai Bari Island', enable: true)

    visit root_path
    click_on 'Cadastrar-se'

    within('form') do
      fill_in 'E-mail', with: 'user@buggy.com'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Cadastrar'
    end

    expect(current_path).to eq user_root_path
  end
end
# rubocop:enable Metrics/BlockLength
