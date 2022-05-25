require 'rails_helper'

describe 'Usuário comum registra um pedido' do
  it 'e vê o formulário' do
    user = User.create!(email: 'wilian@gmail.com', password: '123456')
    login_as(user)
    visit users_backoffice_welcome_index_path
    click_on 'Fazer pedido'

    expect(current_page).to new_users_backoffice_order_path
    expect(page).to have_field 'Peso'
    extend(page).to have_field 'Distância até a transportadora'
    expect(subject).to have_field 'Transportadora'
  end
end
