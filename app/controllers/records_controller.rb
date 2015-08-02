class RecordsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /records
  # GET /records.json
  def index
    @records = Record.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @records }
    end
  end

  # GET /records/1
  # GET /records/1.json
  def show
    @record = Record.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
    end
  end

  # GET /records/new
  # GET /records/new.json
  def new
    @user = current_user
    @task = Task.find(params[:task_id])
    @record = @task.records.build(params[:record])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @record }
    end
  end

  # GET /records/1/edit
  def edit
    @record = Record.find(params[:id])
  end

  # POST /records
  # POST /records.json
  def create
    @user = current_user
    @task = Task.find(params[:task_id])
    @record = @task.records.build(params[:record])

    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'] 
    # get user's number
    @user_number = "+" + current_user.phone_number

    # Add user response to records database: yes/no for .completed & # for .weight
    # Set 'date_sent' to 60 minutes ago: for simplicity, we'll only allow users to set one reminder per hour block
    # All messages sent after one hour will not "count". All messages sent within hour will only belong to most recently sent out reminder....
    @client.account.messages.list({date_sent: 5.minute.ago.to_s(:rfc822), from: @user_number}).each do |message|
      if message.body == ('true' || 'false')
        @record.completed = message.body
      else
        @record.weight = message.body
      end
    end

    respond_to do |format|
      if @record.save
        format.html { redirect_to user_tasks_path, notice: 'Record was successfully created.' }
        format.json { render json: @record, status: :created, location: @record }
      else
        format.html { render action: "new" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /records/1
  # PUT /records/1.json
  def update
    @record = Record.find(params[:id])

    respond_to do |format|
      if @record.update_attributes(params[:record])
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record = Record.find(params[:id])
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url }
      format.json { head :no_content }
    end
  end
end
