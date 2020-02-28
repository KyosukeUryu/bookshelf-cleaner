class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    if @user.has_tags?
      @hash = {}
      @user.finished_books.each do |book|
        book.tag_list.each do |tag|
          # @hash[tag]があれば値を増加、なければ1で設定
          if @hash[tag].present?
            @hash[tag] += 1
          else
            @hash[tag] = 1
          end
        end
      end
    end
  end
end
