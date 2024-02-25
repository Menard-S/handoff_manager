class DashboardController < ApplicationController
  def index
    # Check for a reset parameter or lack of date parameters to display all tasks
    if params[:reset] || (!params.key?(:start_date) && !params.key?(:end_date))
      @tasks = Task.all # Or however you initially retrieve tasks without filtering
    else
      start_date = params[:start_date].present? ? params[:start_date] : Date.today.beginning_of_month
      end_date = params[:end_date].present? ? params[:end_date] : Date.today.end_of_month
      @tasks = DashboardService.new(start_date, end_date).call
    end
  end
end
