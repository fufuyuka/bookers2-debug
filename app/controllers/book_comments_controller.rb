class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end
  
  def destroy
    BookComment.find(params[:id]).destroy
     redirect_back(fallback_location: root_path) #非同期化したらルート不要になる(覚えたら消す)
  end
  
  private
  
    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end
    
    def ensure_correct_user
      @book_comment = BookComment.find(params[:id])
      unless @book_comment.user == current_user
        redirect_to user_path(current_user)
      end
    end

end
