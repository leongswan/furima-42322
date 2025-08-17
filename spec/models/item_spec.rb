require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { build(:item) }

  describe '商品出品' do
    context '出品できるとき' do
      it '必須項目が揃っていれば有効' do
        expect(item).to be_valid
      end
    end

    context '出品できないとき' do
      it '画像が必須' do
        item.image = nil
        item.valid?
        expect(item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須' do
        item.name = ''
        item.valid?
        expect(item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が必須' do
        item.description = ''
        item.valid?
        expect(item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーが---だと無効' do
        item.category_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態が---だと無効' do
        item.condition_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Condition can't be blank")
      end

      it '配送料の負担が---だと無効' do
        item.delivery_fee_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Delivery fee can't be blank")
      end

      it '発送元の地域が---だと無効' do
        item.area_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Area can't be blank")
      end

      it '発送までの日数が---だと無効' do
        item.shipping_day_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Shipping day can't be blank")
      end

      it '価格が必須' do
        item.price = nil
        item.valid?
        expect(item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が300未満は無効' do
        item.price = 299
        item.valid?
        expect(item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end

      it '価格が9,999,999より大きいと無効' do
        item.price = 10_000_000
        item.valid?
        expect(item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end

      it '価格が半角整数以外（全角）は無効' do
        item.price = '１０００'
        item.valid?
        expect(item.errors.full_messages).to include('Price is not a number')
      end

      it 'userが紐づいていなければ保存できない' do
        item.user = nil
        item.valid?
        expect(item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
