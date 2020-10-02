class Item < ApplicationRecord
	attachment :image
	belongs_to :genre
	has_many :cart_items

	has_many :cart_details
	has_many :orders, through: :cart_details

	validates :name, presence: true, length: { maximum: 15 }
	validates :introduction, presence: true, length: { maximum: 70 }
	validates :price, presence: true
	validates :genre_id, presence: true

end
