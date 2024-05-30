class BookingsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @booking = Booking.new
    @costume = Costume.find(params[:costume_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @costume = Costume.find(params[:costume_id])
    @booking.costume = @costume
    @booking.save
    redirect_to restaurant_path(@costume)
  end
end
