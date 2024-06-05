class CostumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]
  before_action :set_costume, only: [:edit, :update, :remove_photo]

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
    @booking = Booking.new  # <------ this is to send a booking variable to the booking.new form inside the costume.show page!
  end

  def new
    @costume = Costume.new
  end

  def create
    @costume = Costume.new(costume_params)
    @costume.user = current_user

    if @costume.save
      redirect_to costume_path(@costume)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @costume = Costume.find(params[:id])
  end

  def update
    if costume_params[:existing_photos].present?
      @costume.photos.each do |photo|
        photo.purge unless costume_params[:existing_photos].include?(photo.key)
      end
    end

    if @costume.update(costume_params.except(:existing_photos))
      redirect_to @costume, notice: 'Costume was successfully updated.'
    else
      render :edit
    end
  end

  def remove_photo
    @costume = Costume.find(params[:id])
    photo = @costume.photos.find(params[:photo_id])
    photo.purge
    redirect_to edit_costume_path(@costume), notice: 'Photo was successfully removed.'
  end

  def destroy
    @costume = Costume.find(params[:id])
    @costume.destroy!
    redirect_to users_index_path, status: :see_other
  end

  private

  def costume_params
    params.require(:costume).permit(:name, :description, :category, :size, :price_per_day, { existing_photos: [] }, photos: [])
  end

  def set_costume
    @costume = Costume.find(params[:id])
  end
end
