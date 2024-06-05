class UsersController < ApplicationController
  before_action :set_costumes, only: [:index]
  def index
    @bookings = current_user.bookings
  end

  private
  
  def set_costumes
    @costumes = Costume.where(user_id: current_user.id)
  end
end
