class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :area
  belongs_to :shipping_day

  with_options presence: true do
    validates :name, :description, :image, :price
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :area_id
    validates :shipping_day_id
  end

  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            }
end
