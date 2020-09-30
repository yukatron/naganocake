class ApplicationController < ActionController::Base

	private
	def current_cart_items
		current_cart_items = CartItem.find_by(id: session[:cart_item_id])
		current_cart_items = CartItem.create  unless current_cart_items
		session[:cart_item_id] = current_cart_items.id
		current_cart_items
	end

end