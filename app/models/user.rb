class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 全角氏名 / 全角カナ
  VALID_ZENKAKU_NAME = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_ZENKAKU_KANA = /\A[ァ-ヶー]+\z/

  with_options presence: true do
    validates :nickname
    validates :last_name,  format: { with: VALID_ZENKAKU_NAME, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :first_name, format: { with: VALID_ZENKAKU_NAME, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :last_name_kana,  format: { with: VALID_ZENKAKU_KANA, message: 'は全角（カタカナ）で入力してください' }
    validates :first_name_kana, format: { with: VALID_ZENKAKU_KANA, message: 'は全角（カタカナ）で入力してください' }
    validates :birth_date
  end

  # パスワード：半角英数字混合・6文字以上・全角禁止
  validate :password_complexity, if: -> { password.present? }

  private

  def password_complexity
    # [!-~] はASCIIの印字可能半角。英字1つ以上＆数字1つ以上を必須
    return if password.match?(/\A(?=.*[A-Za-z])(?=.*\d)[!-~]{6,}\z/)

    errors.add(:password, 'は半角英数字混合で6文字以上にしてください')
  end
end
