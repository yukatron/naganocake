class Admin::OrderDetailsController < ApplicationController
	before_action :authenticate_admin!

	def update
		@order_detail = OrderDetail.find(params[:id])
		@order_detail.update(order_detail_params)
		@order = @order_detail.order
		if params[:order_detail][:making_status] == "製作中"
			@order.update(status: "製作中")
		elsif @order.order_details.where(making_status: "製作完了").count == @order.order_details.count
			@order.update(status: "発送準備中")
		end
		flash[:notice] = "ステータスを更新しました"
		redirect_to admin_order_path(@order_detail.order.id)
	end

	private
	def order_detail_params
		params.require(:order_detail).permit(:making_status)
	end
end
