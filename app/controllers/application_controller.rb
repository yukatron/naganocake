class ApplicationController < ActionController::Base

	def ensure_current_customer
	    if admin_signed_in?
	    	flash[:notice]="アクセス権がありません"
	    	redirect_to admin_top_path
      	elsif
	    current_customer.id != params[:id].to_i || current_customer.is_deleted == true
	    flash[:notice]="アクセス権がありません"
	    redirect_to root_path
	    end
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