class BookCommentsController < ApplicationController
  before_action :ensure_correct_user, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
    #redirect_toがないので/create.js.erbを参照してくれる(非同期通信)
  end
  
  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
    #redirect_toがないので/create.js.erbを参照してくれる(非同期通信)
  end
  
  private
  
    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end
    
    def ensure_correct_user
      @book_comment = BookComment.find(params[:id])
      unless @book_comment.user == current_user
      end
    end

end
