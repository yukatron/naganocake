class Public::ItemsController < ApplicationController
  def top
  end

  def about
  end

  def index
    if params[:genre_id]
      @genres = Genre.all
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(8)
    else
      @genres = Genre.all
      @items = Item.page(params[:page]).per(8)
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end