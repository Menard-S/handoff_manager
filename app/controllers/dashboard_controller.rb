class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    service = DashboardService.new(params[:start_date], params[:end_date], @user)

    if params[:reset] || params[:start_date].blank? || params[:end_date].blank?
  
      @tasks = @user.tasks.order(:deadline_date, :deadline_time)
      @completed_tasks_count = @user.tasks.where(completed: true).count
    else
      @tasks = service.call
      @completed_tasks_count = service.count_completed
    end

    @categories = @user.categories
    @total_tasks_count = service.tasks_count

  end
end
