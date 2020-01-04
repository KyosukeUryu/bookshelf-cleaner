class FinishedBooksController < ApplicationController
  def index
    @finished_books = current_user.finished_books
  end

  def new
    @unread_book = current_user.unread_books.find(params[:id])
    @finished_book = current_user.finished_books.new
    @finished_book.title = params[:title]
    @finished_book.author = params[:author]
  end

  def create
    @unread_book = current_user.unread_books.find(params[:finished_book][:unread_book][:id])
    @finished_book = current_user.finished_books.new(book_params)
    if @finished_book.save
      @unread_book.destroy
      redirect_to root_path, notice: '書籍読破おめでとうございます！'
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:finished_book).permit(:title, :author, :status, :desposal_expired, :impression, :unread_book)
  end
end
