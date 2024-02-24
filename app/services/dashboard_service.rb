class DashboardService
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end
  
    def call
      Task.joins(:category)
          .select('tasks.*, categories.name as category_name, categories.billing_unit')
          .where(deadline_date: @start_date..@end_date)
          .order(deadline_date: :desc, deadline_time: :desc)
    end
  end
  