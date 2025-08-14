require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context '登録できる' do
    it '必須項目が揃っていれば有効' do
      expect(user).to be_valid
    end
  end

  context '必須チェック' do
    it { expect(build(:user, nickname: '')).to be_invalid }
    it { expect(build(:user, email: '')).to be_invalid }
    it { expect(build(:user, last_name: '')).to be_invalid }
    it { expect(build(:user, first_name: '')).to be_invalid }
    it { expect(build(:user, last_name_kana: '')).to be_invalid }
    it { expect(build(:user, first_name_kana: '')).to be_invalid }
    it { expect(build(:user, birth_date: nil)).to be_invalid }
  end

  context 'email の検証' do
    it '一意（大文字小文字区別なし）' do
      create(:user, email: 'Test@ex.com')
      expect(build(:user, email: 'test@ex.com')).to be_invalid
    end
    it '@を含まないと無効' do
      expect(build(:user, email: 'invalid')).to be_invalid
    end
  end

  context 'password の検証' do
    it '必須' do
      u = build(:user, password: '', password_confirmation: '')
      expect(u).to be_invalid
    end
    it '6文字未満は無効' do
      u = build(:user, password: 'a1b2c', password_confirmation: 'a1b2c')
      expect(u).to be_invalid
    end
    it '英字のみは無効' do
      u = build(:user, password: 'abcdef', password_confirmation: 'abcdef')
      expect(u).to be_invalid
    end
    it '数字のみは無効' do
      u = build(:user, password: '123456', password_confirmation: '123456')
      expect(u).to be_invalid
    end
    it '全角を含むと無効' do
      u = build(:user, password: 'ａｂｃ１２３', password_confirmation: 'ａｂｃ１２３')
      expect(u).to be_invalid
    end
    it '確認用と不一致は無効' do
      u = build(:user, password_confirmation: 'a1b2c4')
      expect(u).to be_invalid
    end
  end

  context '氏名の形式' do
    it 'last_name/first_name は全角必須' do
      u = build(:user, last_name: 'Yamada', first_name: 'Taro')
      expect(u).to be_invalid
    end
    it 'last_name_kana/first_name_kana はカタカナ必須' do
      u = build(:user, last_name_kana: 'やまだ', first_name_kana: 'たろう')
      expect(u).to be_invalid
    end
  end
end
