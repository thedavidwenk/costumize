class UsersController < ApplicationController
  before_action :set_costumes, only: [:index]
  def index
    @bookings = current_user.bookings
  end

  def destroy
    @costume = Costume.find(params[:id])     
    @costume.destroy!
    redirect_to users_index_path, status: :see_other
  end

  private
  
  def set_costumes
    @costumes = Costume.where(user_id: current_user.id)
  end
  
  # def set_costumes
  #   @costumes = current_user.costumes
  # end
end
