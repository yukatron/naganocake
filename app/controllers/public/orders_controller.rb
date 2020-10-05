class Public::OrdersController < ApplicationController
  before_action :ensure_current_customer
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
      # 他のuserのアクセス阻止
      unless current_customer.nil? || current_customer.id == @order.customer_id
      flash[:notice] = "アクセス権がありません"
      redirect_to orders_path(id: current_customer.id)
      end

      if params[:_add] == "usersAdd"
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

    if @order.save
      @order = Order.find(params[:id])
      @items = current_customer.cart_items
    else
      render :new
    end
  end

  def create
    item = []
      @items = current_customer.cart_items
      @items.each do |i|
        taxed_price = (i.item.price*1.1).round
        item << @order.order_details.build(item_id: i.item_id, price: taxed_price, quantity: i.quantity, making_status: 0)
      end
    OrderDetail.import item
  end

  def thanks
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, address:[:postal_code, :address, :name])
  end
end
