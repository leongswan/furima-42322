FactoryBot.define do
  factory :order_address, class: 'OrderAddress' do
    postal_code    { '123-4567' }
    area_id        { 2 }
    city           { '渋谷区' }
    address        { '道玄坂1-1' }
    building_name  { 'ビル101' }
    phone_number   { '09012345678' }
    token          { 'tok_abc123' }
  end
end