require 'rails_helper'

describe 'Administrador se registra' do
  it 'e vê o fomulário' do
    # Act
    visit new_admin_registration_path
    within('form') do
      fill_in 'Email', with: 'admin@sistemadefretes.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Registrar-se'
    end

    # Assert
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    within('header') do
      expect(page).to have_content 'Administrador: admin@sistemadefretes.com.br'
      expect(page).to have_button 'Sair'
    end
  end

  it 'e não preenche os capos corretamente' do
    # Act
    visit new_admin_registration_path
    within('form') do
      fill_in 'Email', with: ''
      fill_in 'Senha', with: '123456'
      fill_in 'Confirme sua senha', with: '123456'
      click_on 'Registrar-se'
    end

    # Assert
    expect(page).to have_content 'Email não pode ficar em branco'
  end
end
