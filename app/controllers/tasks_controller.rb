class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.xml
  before_filter :set_task_list
  
  def index
    @tasks = @task_list.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = @task_list.tasks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = @task_list.tasks.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = @task_list.tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to([@task_list,@task], :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to(task_list_task_path(@task_list,@task), :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to task_list_tasks_url(@task_list) }
      format.xml  { head :ok }
    end
  end
  
  def set_done
  	@task = Task.find(params[:id])
  	@task.update_attribute(:is_done,true)
  	@tasks = @task_list.tasks
  	render :update do |page| 
  		page.replace_html 'list', :partial => 'list' 
    end 
  end
  
  def set_pending
  	@task = Task.find(params[:id])
  	@task.update_attribute(:is_done,false)
  	@tasks = @task_list.tasks
  	render :update do |page| 
  		page.replace_html 'list', :partial => 'list' 
    end 
  end
  
  private
  def set_task_list
    @task_list = TaskList.find params[:task_list_id]
  end
  	
end
