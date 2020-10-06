class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!
	def index
		if params[:customer_id]
			@orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).reverse_order
		else
			@orders = Order.page(params[:page]).reverse_order
		end
	end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end

	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		if params[:order][:status] == "入金確認"
			order_details = @order.order_details
			order_details.each do |order_detail|
				order_detail.update(making_status: "製作待ち")
			end
		end
		@order_details = @order.order_details
		flash[:notice] = "ステータスを更新しました"
		redirect_to admin_order_path(@order.id)
	end

	private
	def order_params
		params.require(:order).permit(:status)
	end

end
