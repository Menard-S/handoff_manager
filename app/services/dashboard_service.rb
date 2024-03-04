class DashboardService
    def initialize(start_date, end_date, user)
      @start_date = start_date
      @end_date = end_date
      @user = user
    end
  
    def call
      @user.tasks.joins(:category)
          .select('tasks.*, categories.name as category_name, categories.billing_unit')
          .where(deadline_date: @start_date..@end_date)
          .order(deadline_date: :asc, deadline_time: :asc)
    end
    def count_completed
      @user.tasks.joins(:category)
          .where(completed: true)
          .where(deadline_date: @start_date..@end_date)
          .count
    end
    def tasks_count
      @user.tasks.joins(:category)
          .where(deadline_date: @start_date..@end_date)
          .count
    end
  end
  