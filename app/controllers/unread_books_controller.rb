class UnreadBooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: :tops

  def tops; end

  def index
    @unread_books = current_user.unread_books
  end

  def reading
    @reading_books = current_user.unread_books.where(status: 1)
  end

  def new
    @unread_book = current_user.unread_books.new
  end

  def create
    @unread_book = current_user.unread_books.new(book_params)
    if @unread_book.save
      redirect_to root_path, notice: '未読書籍を登録しました'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @unread_book.update(book_params)
      redirect_to unread_books_path, notice: '未読書籍情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @unread_book.destroy
    redirect_to unread_books_path, notice: '書籍情報を削除しました'
  end

  private

  def book_params
    params.require(:unread_book).permit(:title, :author, :status, :reading_expired)
  end

  def set_book
    @unread_book = current_user.unread_books.find(params[:id])
  end
end
