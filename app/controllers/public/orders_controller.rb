class Public::OrdersController < ApplicationController
  before_action :authenticate!
  before_action :customer_is_deleted

  def new
    if current_customer.cart_items.blank?
      flash[:notice] = "カートが空です"
      redirect_to cart_items_path
    else
      @order = Order.new
      @ads = current_customer.addresses
      @address = Address.new
    end
  end

  def confirm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @ads = current_customer.addresses

      if params[:_add] == "customersAdd"
        @order.address = current_customer.address
        @order.postal_code = current_customer.postal_code
        @addname = current_customer.last_name + current_customer.last_name
        @order.name = @addname
      elsif params[:_add] == "shipAdds"
        @ad = @ads.find(params[:Address][:id])
        @order.address = @ad.address
        @order.postal_code = @ad.postal_code
        @order.name = @ad.name
      elsif params[:_add] == "newAdd"
        @ad = Address.new
        @ad.customer_id = current_customer.id
        @ad.postal_code = params[:address][:postal_code]
        @ad.address = params[:address][:address]
        @ad.name = params[:address][:name]
        @ad.save

        @order.postal_code = params[:address][:postal_code]
        @order.address = params[:address][:address]
        @order.name = params[:address][:name]
      end

    @items = current_customer.cart_items

    unless current_customer.nil? || current_customer.id == @order.customer_id
      flash[:notice] = "アクセス権がありません"
      redirect_to orders_path(id: current_customer.id)
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      item = []
        @items = current_customer.cart_items
        @items.each do |i|
          taxed_price = (i.item.price*1.1).round
          item << @order.order_details.build(item_id: i.item_id, price: taxed_price, quantity: i.quantity, making_status: 0)
        end
      OrderDetail.import item

      cart_items = current_customer.cart_items
      cart_items.destroy_all

      redirect_to thanks_path
    else
      render :new
    end

    unless current_customer.nil? || current_customer.id == @order.customer_id
        flash[:notice] = "アクセス権がありません"
      redirect_to orders_path(id: current_customer.id)
    end

  end

  def thanks
  end

  def index
  end

  def show
  end

  private
    def order_params
      params.require(:order).permit(:postal_code, :address, :name, :payment_method, address:[:postal_code, :address, :name])
    end

  #退会済みユーザーへの対応
    def customer_is_deleted
      if customer_signed_in? && current_customer.is_deleted?
         redirect_to root_path
      end
    end

  #adminでなければcustomerの中で振り分ける
    def authenticate!
      if admin_signed_in?
      else
        authenticate_customer!
     end
    end
end
