class ConcernBooksController < ApplicationController

  def create
    current_user.concern_books.create(finished_book_id: params[:finished_book_id])
    redirect_to others_books_finished_books_path, notice: '気になる書籍に追加しました'
  end

  def destroy
    current_user.concern_books.find(params[:id]).destroy
    redirect_to others_books_finished_books_path, notice: '気になる書籍から外しました'
  end
end
