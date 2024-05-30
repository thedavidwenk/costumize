class CostumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def home
  end

  def index
    @costume = Costume.new
  end

  def show
    @costume = Costume.find(params[:id])
  end

  def new
    @costume = Costume.new
  end

  def create
    @costume = Costume.new(costume_params)
    if @costume.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def costume_params
    params.require(:costume).permit(:name, :description, :category, :size, :price_per_day, photos: [])
  end

  private

  # def set_costumes
  #   @costume = Costume.find(params[:id])
  # end

  # def costume_params
  #   params.require(:costume).permit(:name, :category, :size, :description, :price_per_day, photos: [])
  # end
end
