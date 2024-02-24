class DashboardController < ApplicationController
  def index
    start_date = params[:start_date] || Date.today.beginning_of_month
    end_date = params[:end_date] || Date.today.end_of_month

    @tasks = DashboardService.new(start_date, end_date).call
  end
end
