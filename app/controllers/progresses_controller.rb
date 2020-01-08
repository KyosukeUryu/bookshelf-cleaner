class ProgressesController < ApplicationController
  def create
    progress = current_user.progresses.new(progress_params)
    if progress.save
      redirect_to reading_books_unread_books_path, notice: '進捗メモを更新しました'
    else
      redirect_to reading_books_unread_books_path, notice: 'メモを更新できませんでした'
    end
  end

  def destroy
    progress = Progress.find(params[:id])
    progress.destroy
    redirect_to reading_books_unread_books_path, notice: 'メモを削除しました'
  end

  private

  def progress_params
    params.require(:progress).permit(:content)
  end
end
