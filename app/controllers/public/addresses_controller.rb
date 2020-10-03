class Public::AddressesController < ApplicationController
  def index
  	@add = Address.new
  	@adds = current_customer.addresses
  end

  def create
  	@add = Address.new(address_params)
  	@add.customer_id = current_customer.id
  	if @add.save
  		flash[:notice] = "配送先住所を登録しました"
  		redirect_to addresses_path
  	else
  		@adds = current_customer.addresses
  		render :index
  	end
  end

  def edit
  end

  private
  def address_params
  	params.require(:address).permit(:address, :postal_code, :name)
  end
end
