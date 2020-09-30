class Public::CartItemsController < ApplicationController
	before_action :authenticate_customer!

  def create
  	@cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
  	@cart_item.save
  	redirect_to items_path
  end

  def index
  	@cart_items = CartItem.find_by(customer_id: current_customer.id)
    if @cart_items.blank?
      redirect_to items_path
    end
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
