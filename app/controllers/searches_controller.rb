class SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(word, search)
    else
      @books = Book.looks(word, search)
    end
  end
end
