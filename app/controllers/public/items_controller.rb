class Public::ItemsController < ApplicationController
  def top
    @genres = Genre.where(is_active: true)
    @items = Item.where(favorite: true).page(params[:page]).per(4)
  end

  def about
  end

  def index
    if params[:genre_id]
      @genres = Genre.where(is_active: true)
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_active: true).page(params[:page]).per(8)
    else
      @genres = Genre.where(is_active: true)
      @items = Item.where(is_active: true).page(params[:page]).per(8)
    end
  end

  def show
    @genres = Genre.where(is_active: true)
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end