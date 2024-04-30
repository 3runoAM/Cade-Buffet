def create_buffets
  payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
  payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
  first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                             password: 'password1', role: :owner)
  first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                            crn: '23.261.499/0001-96', phone: '111-111-1111', email: 'buffet1@example.com',
                            description: 'Description 1')
  first_buffet.payment_methods << payment_method_a
  first_buffet.payment_methods << payment_method_b
  first_buffet.save!
  Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                  state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)

  second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                              password: 'password2', role: :owner)
  second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                             crn: '66.867.496/0001-03', phone: '222-222-2222', email: 'buffet2@example.com',
                             description: 'Description 2')
  second_buffet.payment_methods << payment_method_a
  second_buffet.payment_methods << payment_method_b
  second_buffet.save!
  Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                  state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)
end

def create_buffets_with_events
  payment_method_a = PaymentMethod.create!(name: 'Payment Method 1')
  payment_method_b = PaymentMethod.create!(name: 'Payment Method 2')
  first_owner = User.create!(name: 'Fabrício', email: 'email_first_owner@example.com',
                             password: 'password1', role: :owner)
  first_buffet = Buffet.new(user: first_owner, brand_name: 'Buffet 1', company_name: 'Company 1',
                            crn: '31.602.413/0001-70', phone: '111-111-1111', email: 'buffet1@example.com',
                            description: 'Description 1')
  first_buffet.payment_methods << payment_method_a
  first_buffet.payment_methods << payment_method_b
  first_buffet.save!
  Address.create!(street_name: 'Street 1', neighborhood: 'Neighborhood 1', house_or_lot_number: '1',
                  state: 'State 1', city: 'City 1', zip: '11111', buffet: first_buffet)
  first_event = Event.create!(name: 'Event 1', description: 'Description 1', buffet: first_buffet,
                        min_guests: 10, max_guests: 100, standard_duration: 300, menu: 'Menu 1',
                        offsite_event: true, offers_alcohol: true, offers_decoration: true,
                        offers_valet_parking: true)
  first_weekdays_event = EventPrice.create!(event: first_event, standard_price: 1000, extra_guest_price: 100,
                                         extra_hour_price: 50, day_type: :weekday)
  first_weekend_event = EventPrice.create!(event: first_event, standard_price: 1500, extra_guest_price: 150,
                                        extra_hour_price: 75, day_type: :weekend)

  second_owner = User.create!(name: 'Carlos', email: 'email_second_owner@example.com',
                              password: 'password2', role: :owner)
  second_buffet = Buffet.new(user: second_owner, brand_name: 'Buffet 2', company_name: 'Company 2',
                             crn: '18.312.384/0001-43', phone: '222-222-2222', email: 'buffet2@example.com',
                             description: 'Description 2')
  second_buffet.payment_methods << payment_method_a
  second_buffet.payment_methods << payment_method_b
  second_buffet.save!
  Address.create!(street_name: 'Street 2', neighborhood: 'Neighborhood 2', house_or_lot_number: '2',
                  state: 'State 2', city: 'City 2', zip: '22222', buffet: second_buffet)
  second_event = Event.create!(name: 'Event 2', description: 'Description 2', buffet: second_buffet,
                        min_guests: 10, max_guests: 100, standard_duration: 600, menu: 'Menu 2',
                        offsite_event: false, offers_alcohol: true, offers_decoration: true,
                        offers_valet_parking: true)
  second_weekdays_event = EventPrice.create!(event: second_event, standard_price: 2000, extra_guest_price: 200,
                                          extra_hour_price: 100, day_type: :weekday)
  second_weekend_event = EventPrice.create!(event: second_event, standard_price: 2500, extra_guest_price: 250,
                                          extra_hour_price: 125, day_type: :weekend)

  [first_buffet, second_buffet, first_event, second_event]
end