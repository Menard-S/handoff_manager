class DashboardController < ApplicationController
  def index
    service = DashboardService.new(params[:start_date], params[:end_date])

    if params[:reset] || params[:start_date].blank? || params[:end_date].blank?
  
      @tasks = Task.order(:deadline_date, :deadline_time)
      @completed_tasks_count = Task.where(completed: true).count
    else
      @tasks = service.call
      @completed_tasks_count = service.count_completed
    end

    @categories = Category.all
    @total_tasks_count = service.tasks_count

  end
end
