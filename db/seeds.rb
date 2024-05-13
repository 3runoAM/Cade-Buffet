pix = PaymentMethod.create(name: 'Pix')
cartao_credito = PaymentMethod.create(name: 'Cartão de crédito')
cartao_debito = PaymentMethod.create(name: 'Cartão de débito')
boleto = PaymentMethod.create(name: 'Boleto bancário')
transacao = PaymentMethod.create(name: 'Transação bancária')

owner = User.create!(name: 'João Silva', email: 'joao_silva@example.com',
                           password: 'password3', role: :owner)
buffet = Buffet.new(user: owner, brand_name: 'Buffet Estrela do Mar', company_name: 'Estrela do Mar Ltda',
                          crn: '28.824.990/0001-00', phone: '333-333-3333', email: 'estreladomar@example.com',
                          description: 'O Buffet Estrela do Mar oferece uma experiência culinária inesquecível com uma variedade de pratos deliciosos.')
buffet.payment_methods << [pix, cartao_credito, cartao_debito, boleto, transacao]
buffet.save!

Address.create!(street_name: 'Rua das Palmeiras', neighborhood: 'Centro', house_or_lot_number: '123',
                state: 'Paraíba', city: 'Patos', zip: '58700-000', buffet: buffet)
first_event = Event.create!(name: 'Casamento na Praia', description: 'Um evento maravilhoso à beira-mar com decoração temática e menu personalizado.', buffet: buffet,
                            min_guests: 50, max_guests: 200, standard_duration: 600, menu: 'Frutos do Mar',
                            offsite_event: true, offers_alcohol: true, offers_decoration: true,
                            offers_valet_parking: true)
EventPrice.create!(event: first_event, standard_price: 5000, extra_guest_price: 100,
                   extra_hour_price: 200, day_type: :weekday)
EventPrice.create!(event: first_event, standard_price: 7000, extra_guest_price: 150,
                   extra_hour_price: 300, day_type: :weekend)

second_owner = User.create!(name: 'Maria Santos', email: 'maria_santos@example.com',
                     password: 'password4', role: :owner)
second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet Lua Cheia', company_name: 'Lua Cheia Ltda',
                          crn: '82.638.014/0001-08', phone: '444-444-4444', email: 'luacheia@example.com',
                          description: 'O Buffet Lua Cheia oferece uma experiência culinária única com uma variedade de pratos saborosos.')
second_buffet.payment_methods << [pix, cartao_credito, cartao_debito, boleto, transacao]
second_buffet.save!

Address.create!(street_name: 'Rua das Orquídeas', neighborhood: 'Jardim', house_or_lot_number: '456',
                state: 'Paraíba', city: 'Patos', zip: '58700-000', buffet: second_buffet)
second_event = Event.create!(name: 'Festa Tropical', description: 'Um evento incrível com decoração tropical e menu personalizado.', buffet: second_buffet,
                      min_guests: 60, max_guests: 250, standard_duration: 720, menu: 'Comida Tropical',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: second_event, standard_price: 6000, extra_guest_price: 120,
                   extra_hour_price: 250, day_type: :weekday)
EventPrice.create!(event: second_event, standard_price: 8000, extra_guest_price: 160,
                   extra_hour_price: 350, day_type: :weekend)

# Terceiro Buffet
third_owner = User.create!(name: 'Carlos Pereira', email: 'carlos_pereira@example.com',
                           password: 'password5', role: :owner)
third_buffet = Buffet.new(user: third_owner, brand_name: 'Buffet Sol Nascente', company_name: 'Sol Nascente Ltda',
                          crn: '69.071.805/0001-22', phone: '555-555-5555', email: 'solnascente@example.com',
                          description: 'O Buffet Sol Nascente oferece uma experiência culinária exótica com uma variedade de pratos internacionais.')
third_buffet.payment_methods << [pix, cartao_credito, cartao_debito, boleto, transacao]
third_buffet.save!

Address.create!(street_name: 'Rua dos Jasmins', neighborhood: 'Bela Vista', house_or_lot_number: '789',
                state: 'Paraíba', city: 'Patos', zip: '58700-000', buffet: third_buffet)
third_event = Event.create!(name: 'Festa da Primavera', description: 'Um evento vibrante com decoração floral e menu sazonal.', buffet: third_buffet,
                      min_guests: 70, max_guests: 300, standard_duration: 840, menu: 'Comida Vegetariana',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: third_event, standard_price: 7000, extra_guest_price: 140,
                   extra_hour_price: 280, day_type: :weekday)
EventPrice.create!(event: third_event, standard_price: 9000, extra_guest_price: 180,
                   extra_hour_price: 360, day_type: :weekend)

# Quarto Buffet
fourth_owner = User.create!(name: 'Ana Oliveira', email: 'ana_oliveira@example.com',
                            password: 'password6', role: :owner)
fourth_buffet = Buffet.new(user: fourth_owner, brand_name: 'Buffet Terra Verde', company_name: 'Terra Verde Ltda',
                           crn: '54.249.061/0001-16', phone: '666-666-6666', email: 'terraverde@example.com',
                           description: 'O Buffet Terra Verde oferece uma experiência culinária saudável com uma variedade de pratos orgânicos.')
fourth_buffet.payment_methods << [pix, cartao_credito, cartao_debito, boleto, transacao]
fourth_buffet.save!

Address.create!(street_name: 'Rua das Margaridas', neighborhood: 'Flores', house_or_lot_number: '012',
                state: 'Paraíba', city: 'Patos', zip: '58700-000', buffet: fourth_buffet)
fourth_event = Event.create!(name: 'Festa da Terra', description: 'Um evento eco-friendly com decoração sustentável e menu orgânico.', buffet: fourth_buffet,
                      min_guests: 80, max_guests: 350, standard_duration: 960, menu: 'Comida Orgânica',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: fourth_event, standard_price: 8000, extra_guest_price: 160,
                   extra_hour_price: 320, day_type: :weekday)
EventPrice.create!(event: fourth_event, standard_price: 10000, extra_guest_price: 200,
                   extra_hour_price: 400, day_type: :weekend)

# Quinto Buffet
fifth_owner = User.create!(name: 'Pedro Costa', email: 'pedro_costa@example.com',
                           password: 'password7', role: :owner)
fifth_buffet = Buffet.new(user: fifth_owner, brand_name: 'Buffet Céu Azul', company_name: 'Céu Azul Ltda',
                          crn: '42.062.407/0001-93', phone: '777-777-7777', email: 'ceuazul@example.com',
                          description: 'O Buffet Céu Azul oferece uma experiência culinária sofisticada com uma variedade de pratos gourmet.')
fifth_buffet.payment_methods << [pix, cartao_credito, cartao_debito, boleto, transacao]
fifth_buffet.save!

Address.create!(street_name: 'Rua dos Lírios', neighborhood: 'Estrela', house_or_lot_number: '345',
                state: 'Paraíba', city: 'Patos', zip: '58700-000', buffet: fifth_buffet)
fifth_event = Event.create!(name: 'Festa Gourmet', description: 'Um evento elegante com decoração de luxo e menu gourmet.', buffet: fifth_buffet,
                      min_guests: 90, max_guests: 400, standard_duration: 1080, menu: 'Comida Gourmet',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: fifth_event, standard_price: 9000, extra_guest_price: 180,
                   extra_hour_price: 360, day_type: :weekday)
EventPrice.create!(event: fifth_event, standard_price: 11000, extra_guest_price: 220,
                   extra_hour_price: 440, day_type: :weekend)

client1 = User.create!(name: 'João Pedro', email: 'joao_pedro@example.com', password: 'password1', role: :client,
                       cpf: '182.342.840-10')
client2 = User.create!(name: 'Caio Martins', email: 'caio_martins@example.com', password: 'password2', role: :client,
                       cpf: "808.677.250-01")
client3 = User.create!(name: 'Felipe Souza', email: 'felipe_souza@example.com', password: 'password3', role: :client,
                       cpf: "578.611.620-44")
client4 = User.create!(name: 'Juliana Thaís', email: 'juliana_thais@example.com', password: 'password4', role: :client,
                       cpf: "508.563.400-49")
client5 = User.create!(name: 'Roberta Silva', email: 'roberta_silva@example.com', password: 'password5', role: :client,
                       cpf: "639.137.330-27")
client6 = User.create!(name: 'Brendon Costa', email: 'brendon_costa@example.com', password: 'password6', role: :client,
                       cpf: "831.434.220-33")

Order.create!(user: client1, event: first_event, buffet: buffet, total_guests: 100,
              address: "Rua das Flores, Bairro Jardim, 123", event_date: 1.month.from_now.next_weekday, price: 5000,
              additional_info: "Informações adicionais do pedido 1 para o evento 1 em Buffet 1 em 1 mês")

Order.create!(user: client2, event: second_event, buffet: second_buffet, total_guests: 100,
              address: "Avenida do Sol, Bairro Centro, 456", event_date: 2.months.from_now.next_weekday, price: 7500,
              additional_info: "Informações adicionais do pedido 2 para o evento 2 em Buffet 2 em 2 meses")

Order.create!(user: client3, event: third_event, buffet: third_buffet, total_guests: 100,
              address: "Travessa da Lua, Bairro Estrela, 789", event_date: 3.months.from_now.next_weekday, price: 10000,
              additional_info: "Informações adicionais do pedido 3 para o evento 3 em Buffet 3 em 3 meses")

Order.create!(user: client4, event: fourth_event, buffet: fourth_buffet, total_guests: 100,
              address: "Praça das Nuvens, Bairro Céu, 101112", event_date: 4.months.from_now.next_weekday, price: 12500,
              additional_info: "Informações adicionais do pedido 4 para o evento 4 em Buffet 4 em 4 meses")

Order.create!(user: client5, event: fifth_event, buffet: fifth_buffet, total_guests: 100,
              address: "Alameda dos Cometas, Bairro Universo, 131415", event_date: 5.months.from_now.next_weekday, price: 15000,
              additional_info: "Informações adicionais do pedido 5 para o evento 5 em Buffet 5 em 5 meses")

