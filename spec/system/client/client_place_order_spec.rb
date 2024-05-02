require "rails_helper"

describe "Client places order" do
  it "and sees link to do so" do
    client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                          cpf: "595.085.920-01")
    create_buffets_with_events

    login_as client
    visit root_path
    click_on "Buffet 1"

    expect(page).to have_link('Solicitar evento')
  end

  context  "and sees form to place order" do
    it 'with address field for offsite events' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      create_buffets_with_events

      login_as client
      visit root_path
      click_on "Buffet 1"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      expect(current_path).to eq new_client_order_path
      expect(page).to have_content "Buffet: Buffet 1"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_field "Data do evento"
      expect(page).to have_field "Número de convidados"
      expect(page).to have_field "Endereço"
      expect(page).to have_field "Informações adicionais"

      expect(page).to have_button "Solicitar evento"
    end

    it 'without address field for onsite events' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      create_buffets_with_events

      login_as client
      visit root_path
      click_on "Buffet 2"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      expect(current_path).to eq new_client_order_path
      expect(page).to have_content "Buffet: Buffet 2"
      expect(page).to have_content "Evento: Event 2"
      expect(page).to have_field "Data do evento"
      expect(page).to have_field "Número de convidados"
      expect(page).not_to have_field "Endereço (opcional)"
      expect(page).to have_field "Informações adicionais"

      expect(page).to have_button "Solicitar evento"
    end
  end

  context  "sucessfuly" do
    it 'with address field for offsite events filled' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      create_buffets_with_events

      login_as client
      visit root_path
      click_on "Buffet 1"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      fill_in "Data do evento", with: 1.month.from_now.next_weekday
      fill_in "Número de convidados", with: 50
      fill_in "Endereço", with: "Rua 1, Bairro 1, 1"
      fill_in "Informações adicionais", with: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"
      click_on "Solicitar evento"

      expect(current_path).to eq client_order_path(Order.last.id)
      expect(page).to have_content "Evento solicitado com sucesso"
      expect(page).to have_content "Buffet: Buffet 1"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: Rua 1, Bairro 1, 1"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"
      expect(page).to have_content "Preço: R$ 5.000,00"
      expect(page).to have_content "Código do pedido: #{Order.last.code}"
      expect(page).to have_content "Status: Pendente"
    end

    it 'with address field for offsite events unfilled' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      first_buffet, second_buffet = create_buffets_with_events

      login_as client
      visit root_path
      click_on "Buffet 1"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      fill_in "Data do evento", with: 1.month.from_now.next_weekday
      fill_in "Número de convidados", with: 50
      fill_in "Informações adicionais", with: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"

      click_on "Solicitar evento"

      expect(current_path).to eq client_order_path(Order.last)
      expect(page).to have_content "Evento solicitado com sucesso"
      expect(page).to have_content "Buffet: Buffet 1"
      expect(page).to have_content "Evento: Event 1"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: #{first_buffet.address.full_address}"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês"
      expect(page).to have_content "Preço: R$ 5.000,00"
      expect(page).to have_content "Código do pedido: #{Order.last.code}"
      expect(page).to have_content "Status: Pendente"
    end

    it 'without address field for onsite events' do
      client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                            cpf: "595.085.920-01")
      first_buffet, second_buffet = create_buffets_with_events

      login_as client
      visit root_path
      click_on "Buffet 2"
      within '#events' do
        find('div:nth-child(2)').click_on('Solicitar evento')
      end

      fill_in "Data do evento", with: 1.month.from_now.next_weekday
      fill_in "Número de convidados", with: 50
      fill_in "Informações adicionais", with: "Informações adicionais do pedido 1 para o evento 2 em Buffet 2 em 1 mês"
      click_on "Solicitar evento"

      expect(current_path).to eq client_order_path(Order.last)
      expect(page).to have_content "Evento solicitado com sucesso"
      expect(page).to have_content "Buffet: Buffet 2"
      expect(page).to have_content "Evento: Event 2"
      expect(page).to have_content "Data do evento: #{1.month.from_now.next_weekday.strftime('%d/%m/%Y')}"
      expect(page).to have_content "Número de convidados: 50"
      expect(page).to have_content "Endereço: #{second_buffet.address.full_address}"
      expect(page).to have_content "Informações adicionais: Informações adicionais do pedido 1 para o evento 2 em Buffet 2 em 1 mês"
      expect(page).to have_content "Preço: R$ 10.000,00"
      expect(page).to have_content "Código do pedido: #{Order.last.code}"
      expect(page).to have_content "Status: Pendente"
    end
  end

  it 'and sees all orders' do
    first_buffet, second_buffet, first_event, second_event = create_buffets_with_events
    client = User.create!(email: 'client@client.com', password: 'password', name: "Client", role: :client,
                          cpf: "595.085.920-01")

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CODIGO12')
    Order.create!(user_id: client.id, event: first_event, buffet: first_buffet, total_guests: 50, address: "Rua 1, Bairro 1, 1",
                  additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês",
                  event_date: 1.month.from_now.next_weekday, price: 5000)

    login_as client

    visit root_path
    click_on "Área do cliente"

    expect(current_path).to eq client_dashboards_path
    expect(page).to have_content "Meus pedidos"
    expect(page).to have_content "CODIGO12"
    expect(page).to have_content 1.month.from_now.next_weekday.strftime('%d/%m/%Y')
  end
end

