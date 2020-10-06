class Public::CartItemsController < ApplicationController
  before_action :authenticate!
  before_action :customer_is_deleted

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.quantity += params[:cart_item][:quantity].to_i
      @cart_item.save
      redirect_to cart_items_path
    else
      @cart_item = current_customer.cart_items.build(cart_item_params)
      if @cart_item.save
        redirect_to cart_items_path
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
  	if cart_item.destroy
      flash[:notice] = "カート商品を削除しました"
  	redirect_to cart_items_path
    else
      render :index
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "#{@cart_item.item.name}の数量が変更されました"
      redirect_to cart_items_path
    else
      render :index
    end
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    flash[:notice] = "カートを空にしました"
    redirect_to items_path
  end

  private
  def cart_item_params
  	params.require(:cart_item).permit(:quantity, :item_id)
  end

end
