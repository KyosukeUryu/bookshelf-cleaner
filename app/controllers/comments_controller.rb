class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to finished_book_path(@comment.finished_book), notice: 'コメントを投稿しました'
    else
      redirect_to finished_book_path(@comment.finished_book), notice: '投稿できませんでした'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:finished_book_id, :user_id, :content)
  end
end
