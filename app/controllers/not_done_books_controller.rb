class NotDoneBooksController < ApplicationController
  def tops

  end

  def index
    @not_done_books = NotDoneBook.all
  end

  def new
    @not_done_book = NotDoneBook.new
  end

  def create
    @not_done_book = NotDoneBook.new(book_params)
    if @not_done_book.save
      redirect_to root_path, notice: '未読書籍を登録しました'
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def book_params
    params.require(:not_done_book).permit(:title, :author, :status, :reading_expired)
  end
end
