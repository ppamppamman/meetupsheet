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
end
