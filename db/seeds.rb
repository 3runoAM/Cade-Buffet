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
event = Event.create!(name: 'Casamento na Praia', description: 'Um evento maravilhoso à beira-mar com decoração temática e menu personalizado.', buffet: buffet,
                            min_guests: 50, max_guests: 200, standard_duration: 600, menu: 'Frutos do Mar',
                            offsite_event: true, offers_alcohol: true, offers_decoration: true,
                            offers_valet_parking: true)
EventPrice.create!(event: event, standard_price: 5000, extra_guest_price: 100,
                   extra_hour_price: 200, day_type: :weekday)
EventPrice.create!(event: event, standard_price: 7000, extra_guest_price: 150,
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
event = Event.create!(name: 'Festa Tropical', description: 'Um evento incrível com decoração tropical e menu personalizado.', buffet: second_buffet,
                      min_guests: 60, max_guests: 250, standard_duration: 720, menu: 'Comida Tropical',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: event, standard_price: 6000, extra_guest_price: 120,
                   extra_hour_price: 250, day_type: :weekday)
EventPrice.create!(event: event, standard_price: 8000, extra_guest_price: 160,
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
event = Event.create!(name: 'Festa da Primavera', description: 'Um evento vibrante com decoração floral e menu sazonal.', buffet: third_buffet,
                      min_guests: 70, max_guests: 300, standard_duration: 840, menu: 'Comida Vegetariana',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: event, standard_price: 7000, extra_guest_price: 140,
                   extra_hour_price: 280, day_type: :weekday)
EventPrice.create!(event: event, standard_price: 9000, extra_guest_price: 180,
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
event = Event.create!(name: 'Festa da Terra', description: 'Um evento eco-friendly com decoração sustentável e menu orgânico.', buffet: fourth_buffet,
                      min_guests: 80, max_guests: 350, standard_duration: 960, menu: 'Comida Orgânica',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: event, standard_price: 8000, extra_guest_price: 160,
                   extra_hour_price: 320, day_type: :weekday)
EventPrice.create!(event: event, standard_price: 10000, extra_guest_price: 200,
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
event = Event.create!(name: 'Festa Gourmet', description: 'Um evento elegante com decoração de luxo e menu gourmet.', buffet: fifth_buffet,
                      min_guests: 90, max_guests: 400, standard_duration: 1080, menu: 'Comida Gourmet',
                      offsite_event: true, offers_alcohol: true, offers_decoration: true,
                      offers_valet_parking: true)
EventPrice.create!(event: event, standard_price: 9000, extra_guest_price: 180,
                   extra_hour_price: 360, day_type: :weekday)
EventPrice.create!(event: event, standard_price: 11000, extra_guest_price: 220,
                   extra_hour_price: 440, day_type: :weekend)

# first_owner = User.create!(name: 'Fabrício', email: 'first_owner@example.com',
#                            password: 'password1', role: :owner)
# first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
#                           crn: '31.602.413/0001-70', phone: '111-111-1111', email: 'buffet1@example.com',
#                           description: 'Description 1')
# first_buffet.payment_methods << p1
# first_buffet.payment_methods << p2
# first_buffet.payment_methods << p3
# first_buffet.payment_methods << p4
# first_buffet.payment_methods << p5
# first_buffet.save!
#
# Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
#                 state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)
# first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: first_buffet,
#                             min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
#                             offsite_event: true, offers_alcohol: true, offers_decoration: true,
#                             offers_valet_parking: true)
# EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
#                                           extra_hour_price: 50, day_type: :weekday)
# EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
#                                          extra_hour_price: 75, day_type: :weekend)
#
# second_owner = User.create!(name: 'Carlos', email: 'second_owner@example.com',
#                             password: 'password2', role: :owner)
# second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
#                            crn: '18.312.384/0001-43', phone: '222-222-2222', email: 'buffet2@example.com',
#                            description: 'Description 2')
# second_buffet.payment_methods << p1
# second_buffet.payment_methods << p2
# second_buffet.payment_methods << p3
# second_buffet.payment_methods << p4
# second_buffet.payment_methods << p5
# second_buffet.save!
#
# Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
#                 state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)
# second_event = Event.create!(name: 'Event 2', description: 'Description 2', buffet: second_buffet,
#                              min_guests: 10, max_guests: 100, standard_duration: 600, menu: 'Menu 2',
#                              offsite_event: false, offers_alcohol: true, offers_decoration: true,
#                              offers_valet_parking: true)
# EventPrice.create!(event: second_event, standard_price: 2000, extra_guest_price: 200,
#                                            extra_hour_price: 100, day_type: :weekday)
# EventPrice.create!(event: second_event, standard_price: 2500, extra_guest_price: 250,
#                                           extra_hour_price: 125, day_type: :weekend)
