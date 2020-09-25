class Item < ApplicationRecord
	attachment :image
	belongs_to :genre
	validates :name, presence: true, length: { maximum: 10 }
	validates :introduction, presence: true, length: { maximum: 70 }
	validates :price, presence: true
end
