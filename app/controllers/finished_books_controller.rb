class FinishedBooksController < ApplicationController
  def index

  end

  def new
    @finished_book = FinishedBook.new
    @finished_book.title = params[:title]
    @finished_book.author = params[:author]
  end

  def create

  end
end
