class Public::CartItemsController < ApplicationController
	before_action :authenticate_customer!

  def create
    binding.pry
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.quantity += params[:quantity]
      redirect_to items_path
    else
      @cart_item = current_customer.cart_items.build(cart_item_params)
      if @cart_item.save
        redirect_to items_path
      else
        @genres = Genre.all
        @item = Item.find(params[:id])
        render 'public/items#show'
      end
    end
  end

  def index
  	@cart_items = current_customer.cart_items
  end

  def destroy
  	cart_item = CartItem.find(params[:id])
  	cart_item.destroy
  	redirect_to cart_items_path
  end


  private
  def cart_item_params
  	params.require(:cart_item).permit(:quantity, :item_id)
  end

  def set_customer
    @customer = current_customer
  end

end
