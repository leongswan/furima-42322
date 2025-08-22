class OrderAddress
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :token,
                :postal_code, :area_id, :city, :address, :building_name, :phone_number

  with_options presence: true do
    validates :user_id, :item_id, :token, :city, :address
    validates :postal_code,  format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen (例: 123-4567)' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. 10〜11桁の半角数字のみ' }
  end

  validates :area_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      ShippingAddress.create!(
        order_id: order.id,
        postal_code: postal_code,
        area_id: area_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
