class Item < ApplicationRecord
	attachment :image
	belongs_to :genre
	validates :name, presence: true, length: { maximum: 10 }
	validates :introduction, presence: true, length: { maximum: 70 }
	validates :price, presence: true
	validates :genre_id, presence: true
	validates :is_active, inclusion: {in: [true, false]}
end
