class Order < ApplicationRecord

	belongs_to :customer
	has_many :order_details
	has_many :items, through: :order_details

	enum payment_method: {
		credit_card: 0,
		bank_transfer: 1
	}

	enum status: {
		wait: 0,
		payment_confirm: 1,
		in_production: 2,
		prepare_shipping: 3,
		shipped: 4
	}
end
