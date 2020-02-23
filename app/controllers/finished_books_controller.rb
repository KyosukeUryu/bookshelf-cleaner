class FinishedBooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @q = current_user.finished_books.ransack(params[:q])
    @finished_books = @q.result(distinct: true).page(params[:page]).per(10).standard
  end

  def others
    @q = FinishedBook.where.not(user_id: current_user.id).ransack(params[:q])
    @finished_books = @q.result(distinct: true).page(params[:page]).per(10).standard
  end

  def disposal
    @q = FinishedBook.where.not(user_id: current_user.id).where(status: 2).ransack(params[:q])
    @finished_books = @q.result(distinct: true).page(params[:page]).per(10).standard
  end

  def new
    @unread_book = current_user.unread_books.find(params[:id])
    @finished_book = current_user.finished_books.new
    @finished_book.assign_attributes(title: params[:title],author: params[:author], tag_list: params[:tags])
    @image = params[:image]
  end

  def create
    @unread_book = current_user.unread_books.find(params[:finished_book][:unread_book][:id])
    @finished_book = current_user.finished_books.new(book_params)
    @finished_book.image = @unread_book.image if @unread_book.image.present?
    if @finished_book.save
      @unread_book.destroy
      redirect_to root_path, success: '書籍読破おめでとうございます！'
    else
      render :new
    end
  end

  def edit
    redirect_to root_path, danger: '他のユーザーの書籍です' if @finished_book.user != current_user
  end

  def show
    @comment = @finished_book.comments.new
    @comments = @finished_book.comments.page(params[:page]).per(5).order(created_at: :desc)
  end

  def update
    if @finished_book.update(book_params)
      redirect_to finished_books_path, info: '既読書籍情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @finished_book.destroy
    redirect_to finished_books_path, danger: '既読書籍を削除しました'
  end

  private

  def book_params
    params.require(:finished_book).permit(:title, :author, :status, :desposal_expired, :impression, :unread_book, :image, :tag_list, :image_cache)
  end

  def set_book
    @finished_book = FinishedBook.find(params[:id])
  end
end
