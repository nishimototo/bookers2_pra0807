class HomesController < ApplicationController
  def top
  end

  def about
  end

  def cate_search
    @book = Book.new
    @books = Book.cate_search(params[:keyword])
  end
end
