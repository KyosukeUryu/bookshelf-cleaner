class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    if @user.has_tags?
      @hash = {}
      @user.finished_books.each do |book|
        book.tag_list.each do |tag|
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
