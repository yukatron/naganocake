class Public::CartItemsController < ApplicationController
	before_action :authenticate_customer!

  def create
  	customer_id = current_customer.id
  	cart_item = CartItem.new(cart_item_params, customer_id: customer_id)
  	binding.pry
  	cart_item.save
  	redirect_to items_path
  end

  def index
  	@cart_items = CartItem.find_by(customer_id: current_customer.id)
  end

  def destroy
  	cart_item = CartItem.find(params[:id])
  	cart_item.destroy
  	redirect_to cart_items_path
  end


  private
  def cart_item_params
  	params.require(:cart_item).permit(:item_id, :quantity)
  end
end
