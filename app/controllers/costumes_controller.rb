class CostumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]

  def home
  end

  def index
    @costume = Costume.new
    @costumes = Costume.all

    if params[:name].present?
      @costumes = @costumes.where("name ILIKE ?", "%#{params[:name]}%")
    end

    if params[:category].present? && params[:category] != "all"
      @costumes = @costumes.where(category: params[:category])
    end

    if params[:size].present? && params[:size] != "all"
      @costumes = @costumes.where(size: params[:size])
    end

    if params[:available_date].present?
      @costumes = @costumes.where("available_date >= ?", params[:available_date])
    end

    respond_to do |format|
      format.html # renders the normal index.html.erb
      format.js { render partial: 'costumes/results', locals: { costumes: @costumes } } # renders the partial for AJAX requests
    end
  end

  def show
    @costume = Costume.find(params[:id])
  end

  def new
    @costume = Costume.new
  end

  def create
    @costume = Costume.new(costume_params)
    @costume.user = current_user
    raise
    if @costume.save
      redirect_to costume_path(@costume)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def costume_params
    params.require(:costume).permit(:name, :description, :category, :size, :price_per_day, :user, photos: [] )
  end

end
