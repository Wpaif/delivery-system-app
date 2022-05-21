require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe 'Administrador faz login' do
  it 'e vê o formulário' do
    # Act
    visit new_admin_session_path

    # Assert
    expect(current_path).to eq new_admin_session_path
    expect(page).to have_css 'h2', text: 'Login Administrativo'
    within('form') do
      expect(page).to have_field 'Email'
      expect(page).to have_field 'Senha'
    end
  end

  it 'com sucesso' do
    # Arrange
    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    # Act
    visit new_admin_session_path

    within('form') do
      fill_in 'Email',	with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha',	with: '123456'
      click_on 'Entrar'
    end
    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('header') do
      expect(page).to have_content 'Administrador: wilian@sistemadefretes.com.br'
      expect(page).to have_button 'Sair'
    end
  end

  it 'e faz logout' do
    # Arrange
    Admin.create!(email: 'wilian@sistemadefretes.com.br', password: '123456')

    # Act
    visit new_admin_session_path

    within('form') do
      fill_in 'Email',	with: 'wilian@sistemadefretes.com.br'
      fill_in 'Senha',	with: '123456'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    within('header') do
      expect(page).not_to have_content 'Admin: wilian@sistemadefretes.com.br'
      expect(page).not_to have_button 'Sair'
    end
  end
end
# rubocop:enable Metrics/BlockLength
