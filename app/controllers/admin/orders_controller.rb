class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!
	def index
		if params[:customer_id]
			@orders = Order.where(customer_id: params[:customer_id]).page(params[:page])
		else
			@orders = Order.page(params[:page])
		end
	end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		flash[:notice] = "注文ステータスを更新しました"
		redirect_to admin_orders_path
	end

	private
	def order_params
		params.require(:order).permit(:status)
	end

end
