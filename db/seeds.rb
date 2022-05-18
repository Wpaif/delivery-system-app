Admin.create!(email: 'wilian@admin.com', password: '123456')

Carrier.create!(brand_name: 'Pirate Dispatch Organization', corporate_name: "Buggy's Delivery",
  email_domain: 'buggy.com', registered_number: '00.112.112/0001-39',
  billing_address: 'Karai Bari Island', enable: true)

Carrier.create!(brand_name: 'Carrara', corporate_name: 'Transportadora Carrara LTDA',
  email_domain: 'carrara.com', registered_number: '10.117.111/7591-77',
  billing_address: 'Rua N° 0', enable: true)