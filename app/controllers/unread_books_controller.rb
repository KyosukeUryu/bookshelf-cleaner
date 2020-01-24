class UnreadBooksController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: :tops

  def index
    @q = current_user.unread_books.ransack(params[:q])
    @unread_books = @q.result(distinct: true).page(params[:page]).per(10).order(created_at: :desc)
  end

  def reading
    @reading_book = UnreadBook.find(params[:id])
    if @reading_book.not_yet?
      @reading_book.update(status: 1)
      redirect_to unread_books_path, info: "#{@reading_book.title}を読書中書籍に登録しました"
    else
      redirect_to unread_books_path, warning: 'すでに読書中の書籍です'
    end
  end

  def reading_books
    @progresses = current_user.progresses.page(params[:page]).per(5).order(created_at: :desc)
    @progress = Progress.new
    @reading_books = current_user.unread_books.where(status: 1).page(params[:page]).per(4).order(created_at: :desc)
  end

  def return
    @reading_book = UnreadBook.find(params[:id])
    @reading_book.update(status: 0)
    redirect_to reading_books_unread_books_path, warning: '未読書籍に戻しました'
  end

  def search
    if params[:looking_for]
      @search_term = params[:looking_for]
      @number = params[:number].to_i
      uri = URI.parse(URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{@search_term}&startIndex=#{@number}"))
      json = Net::HTTP.get(uri)
      result = JSON.parse(json)
      if result['totalItems'] != 0 && result['totalItems'].present?
        @max_books = result['totalItems']
        @books = result['items']
        @search_books = []
        @books.each do |book|
          @search_books << {
            title: book['volumeInfo']['title'],
            author: book['volumeInfo']['authors']&.join(','),
            image: book['volumeInfo']['imageLinks'] && book['volumeInfo']['imageLinks']['smallThumbnail']
          }
        end
      end
    end
  end

  def new
    @book_image = params[:image]
    @unread_book = current_user.unread_books.new(search_params)
  end

  def create
    @unread_book = current_user.unread_books.new(book_params)
    @unread_book.remote_image_url = params[:unread_book][:image]
    if @unread_book.save
      redirect_to unread_books_path, success: "#{@unread_book.title}を未読書籍に登録しました"
    else
      render :new
    end
  end

  def show; end

  def edit
    @unread_book.image.cache!
  end

  def update
    if @unread_book.update(book_params)
      redirect_to unread_books_path, info: '未読書籍情報を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @unread_book.destroy
    redirect_to unread_books_path, danger: '書籍情報を削除しました'
  end

  private

  def search_params
    params.permit(:title, :author)
  end

  def book_params
    params.require(:unread_book).permit(:title, :author, :status, :reading_expired, :tag_list, :image, :image_cache)
  end

  def set_book
    @unread_book = current_user.unread_books.find(params[:id])
  end
end
