class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :cart_items
  has_many :orders

  validates :last_name, :first_name, presence: true
  validates :last_name_kana, :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/, message: "全角カタカナで入力してください"}
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}
  validates :address,presence: true
  validates :tel, presence: true, format: {with: /\A\d{10,11}\z/}
  validates :email, presence: true

end
