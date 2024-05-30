class CostumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def home
  end

  def index
  end

  def show
    # @costume = Costume.find(params[:id])
  end

  def new
  end

  def create
  end

  private

  # def set_costumes
  #   @costume = Costume.find(params[:id])
  # end

  # def costume_params
  #   params.require(:costume).permit(:name, :category, :size, :description, :price_per_day, photos: [])
  # end
end
