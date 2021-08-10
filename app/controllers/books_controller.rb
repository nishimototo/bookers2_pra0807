class BooksController < ApplicationController
   impressionist :actions=> [:show], unique: [:ip_address]

  def index
    @book = Book.new
    @user = current_user
    to = Time.zone.now.end_of_day
    from = 6.day.ago.beginning_of_day
    @books = Book.includes(:favorited_users).sort{|a,b|
      b.favorited_users.includes(:favorites).where(created_at: from..to).size <=>
      a.favorited_users.includes(:favorites).where(created_at: from..to).size
    }
  end

  def show
    @newbook = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @comment = BookComment.new
    impressionist(@book, nil, unique: [:ip_address])
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end
