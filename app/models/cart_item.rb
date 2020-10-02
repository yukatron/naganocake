class CartItem < ApplicationRecord
	belongs_to :customer
	belongs_to :item

	validates :quantity, numericality: {only_integer: true, greater_than: 0}
	validates :item_id, presence: true, numericality: {only_integer: true}
	validates :customer_id, presence: true, numericality: {only_integer: true}
end
