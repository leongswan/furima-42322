require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item) }
  let(:order_address) do
    described_class.new(
      user_id: user.id, item_id: item.id, token: 'tok_abc123',
      postal_code: '123-4567', area_id: 2, city: '渋谷区',
      address: '道玄坂1-1', building_name: 'ビル101', phone_number: '09012345678'
    )
  end

  context '購入できるとき' do
    it 'すべて正しいと有効' do
      expect(order_address).to be_valid
    end

    it 'building_nameが空でも有効' do
      order_address.building_name = ''
      expect(order_address).to be_valid
    end
  end

  context '購入できないとき' do
    it 'cityが必須' do
      order_address.city = ''
      order_address.valid?
      expect(order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'postal_codeが必須' do
      order_address.postal_code = ''
      order_address.valid?
      expect(order_address.errors.added?(:postal_code, :blank)).to be true
    end

    it 'postal_codeは「3桁-4桁」の半角でなければ無効' do
      order_address.postal_code = '1234567'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen (例: 123-4567)')
    end

    it 'area_idは1以外でなければ無効' do
      order_address.area_id = 1
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Area can't be blank")
    end

    it 'addressが必須' do
      order_address.address = ''
      order_address.valid?
      expect(order_address.errors.added?(:address, :blank)).to be true
    end

    it 'phone_numberが必須' do
      order_address.phone_number = ''
      order_address.valid?
      expect(order_address.errors.added?(:phone_number, :blank)).to be true
    end

    it 'phone_numberはハイフン不可' do
      order_address.phone_number = '090-1234-5678'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'phone_numberは10〜11桁でなければ無効（短い/長い）' do
      order_address.phone_number = '090123456'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Phone number is invalid')

      order_address.phone_number = '090123456789'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'tokenが必須' do
      order_address.token = ''
      order_address.valid?
      expect(order_address.errors.added?(:token, :blank)).to be true
    end

    it 'user_idが必須' do
      order_address.user_id = nil
      order_address.valid?
      expect(order_address.errors.added?(:user_id, :blank)).to be true
    end

    it 'item_idが必須' do
      order_address.item_id = nil
      order_address.valid?
      expect(order_address.errors.added?(:item_id, :blank)).to be true
    end
  end
end
