class CartItem < ApplicationRecord
	belongs_to :customer
	belongs_to :item

	validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
	validates :item_id, presence: true, numericality: {only_integer: true}
	validates :customer_id, presence: true, numericality: {only_integer: true}
end
