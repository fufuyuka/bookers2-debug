class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]
  impressionist :actions => [:show]

  def show
    @book = Book.find(params[:id])
    @nbook = Book.new
    impressionist(@book, nil, unique: [:session_hash])
    @book_comment = BookComment.new
  end

  def index
    @nbook = Book.new
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b| 
      b.favorites.where(created_at: from...to).size <=> 
      a.favorites.where(created_at: from...to).size
    } #過去1週間のいいね多い順
    #@books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size} すべてのいいね多い順
    #@books = Book.all デフォルトの投稿古い順
  end

  def create
    @nbook = Book.new(book_params)
    @nbook.user_id = current_user.id
    if @nbook.save
      redirect_to book_path(@nbook), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
  
  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
  
end
