FactoryBot.define do
  factory :shipping_address do
    postal_code { 'MyString' }
    area_id { 1 }
    city { 'MyString' }
    address { 'MyString' }
    building_name { 'MyString' }
    phone_number { 'MyString' }
    order { nil }
  end
end
