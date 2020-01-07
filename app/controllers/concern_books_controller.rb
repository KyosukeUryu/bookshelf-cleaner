class ConcernBooksController < ApplicationController

  def create
    @concern_book = current_user.concern_books.create(finished_book_id: params[:finished_book_id])
    redirect_to others_books_finished_books_path, notice: 'お気に入りに登録しました'
  end

  def destroy

  end
end
