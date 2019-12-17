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
