class BookingsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_costume, only: [:new, :create]

  def index
    # trying to grab the bookings first, so I can access the related costumes
    @bookings = current_user.bookings
  end

  # def new
  #   @booking = Booking.new    <------- not necessary because the form is being displayed in the costume.show page! See costumes_controller#show....
  # end

  def create
    @booking = Booking.new(booking_params)
    @booking.costume = @costume
    @booking.user = current_user


    if booking_overlap?(@costume.id, @booking.start_date, @booking.end_date)
      flash.now[:alert] = "The costume is already booked for the selected dates...try again!"
      render 'costumes/show', status: :unprocessable_entity
    elsif @booking.start_date < Date.today
      flash.now[:alert] = "You cannot book a costume for a past date...try again!"
      render 'costumes/show', status: :unprocessable_entity
    else
      if @booking.save

      else
        flash.now[:alert] = "Booking failed, probably a validation error! Please try again"
        render 'costumes/show', status: :unprocessable_entity
      end
    end   end

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

  def booking_overlap?(costume_id, start_date, end_date)
    existing_bookings = Booking.where(costume_id: costume_id)
    existing_bookings.any? do |existing_booking|
      (existing_booking.start_date < end_date) && (existing_booking.end_date > start_date)
    end
  end

end
