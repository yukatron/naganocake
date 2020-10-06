class Public::AddressesController < ApplicationController
  before_action :ensure_current_customer
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
    @add = Address.find(params[:id])
  end

  def update
    @add = Address.find(params[:id])
    @add.update(address_params)
    flash[:notice] ="配送先を編集しました"
    redirect_to addresses_path
  end

  def destroy
    add = Address.find(params[:id])
    add.destroy
    flash[:notice] ="配送先を削除しました"
    redirect_to addresses_path
  end

  private
  def address_params
  	params.require(:address).permit(:address, :postal_code, :name)
  end
end
