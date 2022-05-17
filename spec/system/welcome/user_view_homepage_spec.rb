require 'rails_helper'

describe 'Usuário visita a homepage' do
  it 'e vê o título da aplicação' do
    visit root_path

    expect(current_path).to eq root_path
    within('header') do
      expect(page).to have_css 'h1', text: 'Sistema de Entregas'
    end
  end
end
