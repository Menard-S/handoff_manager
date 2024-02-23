class TasksController < ApplicationController
    before_action :set_category
    before_action :set_task, only: [:show, :edit, :update, :destroy]
  
    # GET /categories/:category_id/tasks
    def index
      @tasks = @category.tasks.order(deadline_date: :desc, deadline_time: :desc)
    end    
  
    # GET /categories/:category_id/tasks/new
    def new
      @task = @category.tasks.build
    end
  
    # POST /categories/:category_id/tasks
    def create
      @task = @category.tasks.build(task_params)
      if @task.save
        redirect_to category_tasks_path(@category), notice: 'Task was successfully created.'
      else
        render :new
      end
    end    
  
    # GET /categories/:category_id/tasks/:id
    def show
    end
  
    # GET /categories/:category_id/tasks/:id/edit
    def edit
    end
  
    # PATCH/PUT /categories/:category_id/tasks/:id
    def update
      if @task.update(task_params)
        redirect_to [@category, @task], notice: 'Task was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /categories/:category_id/tasks/:id
    def destroy
      @task.destroy
      redirect_to category_tasks_url(@category), notice: 'Task was successfully destroyed.'
    end

    
    def mark_complete
      @task = @category.tasks.find(params[:id])
      is_completed = @task.completed?
      if @task.update(completed: !is_completed)
        notice_message = is_completed ? 'Task was marked as incomplete.' : 'Task was marked as complete.'
        redirect_to category_tasks_path(@category), notice: notice_message
      else
        redirect_to category_tasks_path(@category), alert: 'Unable to update task.'
      end
    end

    def mark_incomplete
      @task = @category.tasks.find(params[:id])
      if @task.update(completed: false)
        redirect_to category_tasks_path(@category), notice: 'Task was marked as incomplete.'
      else
        redirect_to category_tasks_path(@category),
    alert: 'Unable to mark task as incomplete.'
      end
    end
  
    private
  
    def set_category
      @category = Category.find(params[:category_id])
    end
  
    def set_task
      @task = @category.tasks.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(
        :name,
        :deadline_date,
        :deadline_time,
        :hours,
        word_counts: [:new_word, :fuzzy_75_84, :fuzzy_85_94, :fuzzy_95_99, :leveraged_match]
      )
    end    
    
end
  