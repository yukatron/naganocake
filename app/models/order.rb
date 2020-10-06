class Order < ApplicationRecord

	belongs_to :customer
	has_many :order_details, dependent: :destroy
	has_many :items, through: :order_details
	accepts_nested_attributes_for :order_details

	validates :postal_code, presence: true, format: {with: /\A\d{7}\z/}
	validates :address,presence: true
	validates :name, presence: true
	validates :shipping_cost, presence: true
	validates :total_payment, presence: true
	validates :payment_method, presence: true
	validates :status, presence: true

	enum payment_method: {
		クレジットカード: 0,
		銀行振込: 1
	}

	enum status: {
		入金待ち: 0,
		入金確認: 1,
		製作中: 2,
		発送準備中: 3,
		発送済み: 4
	}

end
