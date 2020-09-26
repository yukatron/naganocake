class Public::ItemsController < ApplicationController
  def top
  end

  def about
  end

  def index
  	@genres = Genre.all
  end

  def show
  end
end
