class FavoritesController < ApplicationController
    
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #renderやredirect_toがないので/create.js.erbを参照してくれる(非同期通信)
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #renderやredirect_toがないので/destroy.js.erbを参照してくれる(非同期通信)
  end
  
end
