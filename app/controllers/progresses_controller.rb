class ProgressesController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @progress = current_user.progresses.new(progress_params)
    @progress.save
    render :index
  end

  def destroy
    @progress = Progress.find(params[:id])
    @progress.destroy
    render :index
  end

  private

  def progress_params
    params.require(:progress).permit(:content)
  end
end
