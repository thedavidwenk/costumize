class CostumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :index, :show]
  before_action :set_costume, only: [:edit, :update, :remove_photo]

  def home
  end

  def index
    @costume = Costume.new
    @costumes = Costume.all

    if params[:name].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @costumes = @costumes.where(sql_query, query: "%#{params[:name]}%")
    end

    if params[:category].present? && params[:category] != "all"
      @costumes = @costumes.where(category: params[:category])
    end

    if params[:size].present? && params[:size] != "all"
      @costumes = @costumes.where(size: params[:size])
    end

    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @costumes = @costumes.reject do |costume|
        booking_overlap?(costume, start_date, end_date)
      end
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
    if @costume.update(costume_params.except(:photos, :existing_photos))
      if costume_params[:photos].present?
        @costume.photos.attach(costume_params[:photos])
      end

      redirect_to users_index_path, notice: 'Costume was successfully updated.'
    else
      render :edit
    end
  end

  def remove_photo
    photo = @costume.photos.find(params[:photo_id])
    photo.purge if photo.present?
    redirect_to edit_costume_path(@costume), notice: 'Photo was successfully removed.'
  end


  def destroy
    @costume = Costume.find(params[:id])

    if @costume.bookings.where(end_date: Date.today..).exists?
      redirect_to users_index_path, alert: "Can't delete this costume. You still have open bookings."
    else
      @costume.destroy!
      redirect_to users_index_path, status: :see_other, notice: "Costume deleted successfully"
    end
  end

  private

  def costume_params
    params.require(:costume).permit(:name, :description, :category, :size, :price_per_day, photos: [], existing_photos: [])
  end


  def set_costume
    @costume = Costume.find(params[:id])
  end

  def booking_overlap?(costume, start_date, end_date)
    costume.bookings.any? do |booking|
      (booking.start_date < end_date) && (booking.end_date > start_date)
    end
  end
end
