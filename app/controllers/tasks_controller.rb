class TasksController < ApplicationController
  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @user = current_user
    @tasks = @user.tasks.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show    
    @user = current_user
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! in new method"
    @task = Task.new
    @user = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @user = current_user
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! increate method"
    @user = current_user
    @task = @user.tasks.build(params[:task])


    account_sid = 'ACce2ac884ee78da5155fc87f7bbc0cb4a' 
    auth_token = '40f5a6b6a24f8cae7760b7151563a18a' 
    @client = Twilio::REST::Client.new account_sid, auth_token 

    @client.account.messages.create({
      :from => '+16087136449', 
      :to => '8155203817', 
      :body => @task.message  
    })




    respond_to do |format|
      if @task.save
        format.html { redirect_to user_tasks_path, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @user = current_user
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to user_tasks_path, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to user_tasks_path }
      format.json { head :no_content }
    end
  end
end