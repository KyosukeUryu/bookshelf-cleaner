class ProgressesController < ApplicationController
  before_action :authenticate_user!
  def create
    @progress = current_user.progresses.new(progress_params)
    respond_to do |format|
      if @progress.save
        format.js { render :index }
      else
        format.html { redirect_to reading_books_unread_books_path, danger: 'メモを入力してください' }
      end
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
