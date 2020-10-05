class Admin::CustomersController < ApplicationController
	before_action :authenticate_admin!
  def index
  	@customers = Customer.page(params[:page])
  end

  def show
  	@customer = Customer.find(params[:id])
  end

  def edit
  	@customer = Customer.find(params[:id])
  end

  def update
  	@customer = Customer.find(params[:id])
  	if @customer.update(customer_params)
  		flash[:notice] = "変更を保存しました"
  		redirect_to admin_customers_path
  	else
  		render :edit
  	end
  end

  private
  def customer_params
  	params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :tel, :email, :is_deleted)
  end
end
