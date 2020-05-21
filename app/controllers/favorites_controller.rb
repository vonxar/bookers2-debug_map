class FavoritesController < ApplicationController

 def create
    @favorite = current_user.favorites.create(book_id: params[:book_id])
    @book = Book.find(params[:book_id])
 end
 def destroy
   @favorite = current_user.favorites.find_by(book_id: params[:book_id].to_i).destroy
   @book = Book.find(params[:book_id])
 end
 
end
