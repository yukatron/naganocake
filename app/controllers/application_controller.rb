class ApplicationController < ActionController::Base

	def ensure_current_customer
	    if current_customer.id != params[:id].to_i || current_customer.is_deleted == true
	    flash[:notice]="アクセス権がありません"
	    redirect_to root_path
	    end
  	end
end