class GoalsController < ApplicationController

  def new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors] = ["Fuck your goal"]
    end
  end



  private

  def goal_params
    params.require(:goal).permit(:title, :description, :private)
  end
end
