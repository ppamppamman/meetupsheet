class GroupController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def list
    @groups = Group.all
  end

  def find
  end

  def join
  end

  #POST /group/create
  def create
    return false if params[:name] == "" or params[:description] == ""
    
    group = Group.create(name: params[:name], description: params[:description])
    
    Entry.create(group_id: group.id, user_id: current_user.id)
    redirect_to '/group/list'
  end

  def new
  end

  def destroy
  end

  def show
    @group = Group.find(params[:id])
    @analysis_arr = calculate(params[:id])
    @preiods = ["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"]
  end

  def enroll
    group = Group.find(params[:id])
    group.entries.where(user_id: current_user.id).first_or_create
    redirect_to "/group/show/#{group.id}"
  end

  def calculate(id)
    days = [0,1,2,3,4]
    start_times = ["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"]
    group = Group.find(id)
    
    arr = []
    days.each do |day|
      day_arr = []
      start_times.each do |start_time|
        
        start_time_count = 0
        group.entries.each_with_index do |entry|
          entry.user.schedules.take.periods.each_with_index do |period, index|
            if period.start == start_time and period.day == day
              start_time_count = start_time_count+1
            end
          end
        end        
        day_arr.push(start_time_count)
      end
      
      arr.push(day_arr)
    end
    return arr    
  end

  def notes_list
    @group = Group.find(params[:group_id])
  end

  def new_editor
    @group = Group.find(params[:group_id])
  end

  def show_editor
    @note = Note.find(params[:note_id])
    @group = Group.find(params[:group_id])
  end
  
  def note_create
    if params[:group_id] == "" or params[:title] == "" or params[:contents] == ""
      return render json: {
        result: "error occured!! find admin!!", 
        message: "ERROR"
      }, status: :ok
    else
      begin
        note = Group.find(params[:group_id]).notes.create(
          title: params[:title],
          contents: params[:contents]
        )
        return render json: {
          result: note, 
          message: "OK"
        }, status: :ok
      rescue
        return render json: {
          result: "error occured!! find admin!!", 
          message: "ERROR"
        }, status: :ok
      end
    end
  end
  
  def note_update
    if params[:group_id] == "" or params[:title] == "" or params[:contents] == ""
      return render json: {
        result: "error occured!! find admin!!", 
        message: "ERROR"
      }, status: :ok
    else
      begin
        note = Group.find(params[:group_id]).notes.find(params[:note_id]).update(
          title: params[:title],
          contents: params[:contents]
        )
        return render json: {
          result: note, 
          message: "OK"
        }, status: :ok
      rescue
        return render json: {
          result: "error occured!! find admin!!", 
          message: "ERROR"
        }, status: :ok
      end
    end
  end
end
