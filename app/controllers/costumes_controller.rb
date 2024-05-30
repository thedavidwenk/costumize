class CostumesController < ApplicationController
  before_action only: [:show, :new, :create]

  def home
  end

  def index
    @costumes = Costume.all
  end

  def show
  end

  def new
  end

  def create
  end

  private

  def set_costumes
    @costume = Costume.find(params[:id])
  end

  def costume_params
    params.require(:costume).permit(:name, :category, :size, :description, :price_per_day, photos: [])
  end
end
