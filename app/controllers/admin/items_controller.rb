class Admin::ItemsController < ApplicationController
  def index
  end

  def new
  	@item =Item.new
    @genres = Genre.all
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
  end

  def edit
  end

  private
  def item_params
  	params.require(:item).permit(:name, :interoduction, :image, :price, :is_active).merge(genre_id: params[:id] )
  end
end
