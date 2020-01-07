class FinishedBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @q = current_user.finished_books.ransack(params[:q])
    @finished_books = @q.result(distinct: true)
  end

  def others_books
    @q = FinishedBook.where.not(user_id: current_user.id).ransack(params[:q])
    @finished_books = @q.result(distinct: true)
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

  def edit; end

  def show
    @comment = @finished_book.comments.new
    @comments = @finished_book.comments
  end

  def update
    if @finished_book.update(book_params)
      redirect_to finished_books_path, notice: '既読書籍情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @finished_book.destroy
    redirect_to finished_books_path, notice: '既読書籍を削除しました'
  end

  private

  def book_params
    params.require(:finished_book).permit(:title, :author, :status, :desposal_expired, :impression, :unread_book)
  end

  def set_book
    @finished_book = FinishedBook.find(params[:id])
  end
end
