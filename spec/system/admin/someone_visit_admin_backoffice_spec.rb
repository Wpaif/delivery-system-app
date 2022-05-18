require 'rails_helper'

describe 'Alguém visita o backoffice administrativo' do
  it 'e é direcionado para o login' do
    # Act
    visit admin_path

    # Assert
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'com sucesso' do
    # Arrange
    Admin.create!(email: 'wilian@admin.com', password: '123456')

    # Act
    visit admin_path
    within('form') do
      fill_in 'Email', with: 'wilian@admin.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    # Assert
    expect(current_path).to eq admin_path
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_css 'h1', text: 'Área Administrativa'
  end
end
