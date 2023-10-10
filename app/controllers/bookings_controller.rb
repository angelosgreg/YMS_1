class BookingsController < ApplicationController
  before_action :set_yacht, only: [:create, :destroy]


  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @yacht
    authorize @booking
    authorize @yacht

    if @booking.save!
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @booking
    @booking.destroy
    redirect_to root_path, notice: 'Booking was successfully destroyed!', status: :see_other
  end

  private

  def booking_params
    params.require(:booking).permit(:checkin, :checkout, :people, :yacht_id)
  end

  def set_flat
    @flat = Flat.find(params[:yacht_id])
  end
end
