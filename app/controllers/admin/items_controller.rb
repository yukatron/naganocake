class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page]).reverse_order
  end

  def new
  	@item =Item.new
  end

  def create
  	@item = Item.new(item_params)
  	if !params[:item][:genre_id].nil? && @item.save
  		flash[:notice] = "新しい商品が登録されました"
  		redirect_to admin_item_path(@item.id)
  	else
  		render :new
  	end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "新しい変更が保存されました"
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  private
  def item_params
  	params.require(:item).permit(:name, :introduction, :image, :price, :is_active, :genre_id, :favorite)
  end
end
