class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nick_name, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }

  validates :kanji_first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' }
  validates :kanji_last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' }
  validates :kana_first_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナを使用してください' }
  validates :kana_last_name, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナを使用してください' }
  validates :birthday_yyyy_mm_dd, presence: true

  has_many :items
  has_many :orders
end
