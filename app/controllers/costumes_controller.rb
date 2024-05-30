class CostumesController < ApplicationController
  def home
  end

  def index
  end

  def show
    @costume = Costume.find(params[:id])
  end

  def new
  end

  def create
  end
end
