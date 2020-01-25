class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to finished_book_path(@comment.finished_book), success: 'コメントを投稿しました'
    else
      redirect_to finished_book_path(@comment.finished_book), danger: '投稿できませんでした'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:finished_book_id, :user_id, :content)
  end
end
