class ProgressesController < ApplicationController
  before_action :authenticate_user!
  def create
    progress = current_user.progresses.new(progress_params)
    if progress.save
      redirect_to reading_books_unread_books_path
    else
      redirect_to reading_books_unread_books_path
    end
  end

  def destroy
    progress = Progress.find(params[:id])
    progress.destroy
    redirect_to reading_books_unread_books_path
  end

  private

  def progress_params
    params.require(:progress).permit(:content)
  end
end
