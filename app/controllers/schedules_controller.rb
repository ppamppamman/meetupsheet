class SchedulesController < ApplicationController
  # schedules#index
  def index
  end
  
  # PUT	/users/:user_id/schedules/:id(.:format)	
  # schedules#update
  def update
    begin
      current_user.schedules.take.periods.destroy_all
      JSON.parse(params[:schedule]).each do |day_schedule|
        day_schedule["periods"].each do |period|
          current_user.schedules.take.periods.where(
            day: day_schedule["day"],
            start: period["start"],
            end: period["end"]
          ).first_or_create
        end
      end
      return render json: {
        result: current_user.schedules.take.periods, 
        message: "OK"
      }, status: :ok
    rescue
      return render json: {
        result: "error occured!! find admin!!", 
        message: "ERROR"
      }, status: :ok
    end
  end
  
  # DELETE	/users/:user_id/schedules/:id(.:format)	
  # schedules#destroy
  def destroy
  end

end
