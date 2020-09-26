class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
  	@item =Item.new
  end

  def create
  	@item = Item.new(item_params)
  	if @item.save
  		flash[:notice] = "新しい商品が登録されました"
  		redirect_to admin_items_path
  	else
  		render :new
  	end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  private
  def item_params
  	params.require(:item).permit(:name, :introduction, :image, :price, :is_active, :genre_id)
  end
end
