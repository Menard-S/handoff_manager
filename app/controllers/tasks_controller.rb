class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_task, except: [:new, :create, :index]
  
    def index
      @tasks = @category.tasks.order(deadline_date: :asc, deadline_time: :asc)
    end    
  
    def new
      @task = Task.new
    end
  
    def create
      params[:task][:deadline_time] = in_time_zone(params[:task][:deadline_time])
      @task = @category.tasks.build(task_params)
      if @task.save
        redirect_to [@category, @task], notice: 'Task was successfully created.'
      else
        render :new
      end
    end    
  
    def show
    end

    def edit
    end

    def update
      @task.assign_attributes(task_params)
    
      if @task.valid?
        @task.save
        redirect_to [@category, @task], notice: 'Task was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @task = Task.find(params[:id])
      @task.destroy
    
      if params[:from_dashboard]
        redirect_to dashboard_path, notice: 'Task was successfully deleted.'
      elsif params[:from_task]
        redirect_to category_tasks_path(@category), notice: 'Task was successfully deleted.'
      else
        redirect_to categories_path, notice: 'Task was successfully deleted.'
      end
    end
    
    def mark_complete
      @task = @category.tasks.find(params[:id])
      is_completed = @task.completed?
      
      if @task.update(completed: !is_completed)
        notice_message = is_completed ? 'Task was marked as incomplete.' : 'Task was marked as complete.'
        redirect_back(fallback_location: category_tasks_path(@category), notice: notice_message)
      else
        alert_message = @task.errors.full_messages.to_sentence
        redirect_back(fallback_location: category_tasks_path(@category), alert: alert_message)
      end
    end
      
    
    private

    def in_time_zone(time_string)
      # Parse the time string in the Asia/Manila time zone and return as UTC
      ActiveSupport::TimeZone['Asia/Manila'].parse(time_string).utc if time_string.present?
    end
  
    def set_category
      @category = current_user.categories.find(params[:category_id])
    end
  
    def set_task
      @task = @category.tasks.find(params[:id])
    end
  
    def task_params
      permitted_params = [:name, :deadline_date, :deadline_time]
      billing_unit = @category.billing_unit
      
      case billing_unit
      when 'HOURS'
        permitted_params << :hours
      when 'WORDS'
        permitted_params << { word_counts: [:new_word, :fuzzy_75_84, :fuzzy_85_94, :fuzzy_95_99, :leveraged_match] }
      end
      
      params.require(:task).permit(*permitted_params)
    end
end
  