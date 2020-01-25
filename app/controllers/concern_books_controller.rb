class ConcernBooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @concern_books = current_user.concern_books.page(params[:page]).per(10).order(created_at: :desc)
  end

  def create
    current_user.concern_books.create(finished_book_id: params[:finished_book_id])
    redirect_to others_finished_books_path, success: '気になる書籍に追加しました'
  end

  def destroy
    current_user.concern_books.find(params[:id]).destroy
    redirect_to others_finished_books_path, danger: '気になる書籍から外しました'
  end
end
