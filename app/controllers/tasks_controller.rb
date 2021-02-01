class TasksController < ApplicationController
  before_action :load_task, only: %i[up down]
  
  #START: new update
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to @task, notice: "project was successfully updated"
    else
      render action :edit
    end
  end
  #END: new update

  def create
    @project = Project.find(params[:task][:project_id])
    @project.tasks.create(
      task_params.merge(project_order: @project.next_task_order))
    redirect_to(@project)
  end

  def up
    @task.move_up
    redirect_to(@task.project)
  end

  def down
    @task.move_down
    redirect_to(@task.project)
  end

  private

  def load_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:project_id, :title, :size)
  end
end
