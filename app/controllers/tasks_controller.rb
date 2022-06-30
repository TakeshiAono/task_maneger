class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.order(created_at: "DESC")
    @tasks = Task.all.order(priority: "DESC") if params[:sort_priority]
    @tasks = Task.all.order(deadline: "DESC") if params[:sort_expired]
    if params[:search]
      @tasks = Task.where('title like ?',"%#{params[:search][:title_search]}%") if params[:search][:title_search].present?
      @tasks = @tasks.where('status like ?',"#{params[:search][:status_search]}") if params[:search][:status_search].present?
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    # @task.status.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    if task_params[:priority] == "low"
      new_params = task_params
      new_params["priority"] =1
    elsif task_params[:priority] == "middle"
      new_params = task_params
      new_params["priority"] =2
    elsif task_params[:priority] == "high"
      new_params = task_params
      new_params["priority"] =3
    else
      raise
    end
    @task = Task.new(new_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:user_id, :priority, :title, :deadline, :status)
    end
end
