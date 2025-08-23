FactoryBot.define do
  factory :item do
    name { 'テスト商品' }
    description { 'テスト説明' }
    category_id { 2 }
    condition_id { 2 }
    delivery_fee_id { 2 }
    area_id { 2 }
    shipping_day_id { 2 }
    price { 1000 }
    association :user

    after(:build) do |item|
      next if item.image.attached?

      path = Rails.root.join('spec/fixtures/files/leonbigcat_small.png')
      File.open(path) do |file|
      item.image.attach(
        io: file,
        filename: 'leonbigcat_small.png',
        content_type: 'image/png'
      )
      end
    end
  end
end
