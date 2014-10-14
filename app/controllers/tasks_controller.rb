class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id)
    else
      # id is generated only when it saves to the database
      # If it doesn't save, no id is generated
      render 'new'
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :completed, :due_at)
    end
end
