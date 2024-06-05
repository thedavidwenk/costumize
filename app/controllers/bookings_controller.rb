class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_costume, only: [:new, :create]

  def index
    # trying to grab the bookings first, so I can access the related costumes
    @bookings = current_user.bookings
  end

  def new
    @booking = Booking.new
    @costume = Costume.find(params[:costume_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.costume = @costume
    @booking.user = current_user

    Rails.logger.info "Booking Params: #{booking_params.inspect}"
    Rails.logger.info "Booking Valid: #{@booking.valid?}"
    Rails.logger.info "Booking Errors: #{@booking.errors.full_messages}"

    if @booking.save
      redirect_to users_index_path(@costume)
    else
      render :costumes[@costume], alert: "Booking failed. Please try again", status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:user, :costume, :start_date, :end_date)
  end

  def set_costume
    @costume = Costume.find(params[:costume_id])
  end

end
