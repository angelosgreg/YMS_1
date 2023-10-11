class YachtsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_yacht, only: [:edit, :update, :destroy, :show]
  before_action :map_yacht, only: [:tracker, :tracker_move]

  def index
    if current_user.crew.present?
      @yachts = Yacht.joins(:user).where(users: { crew: current_user.crew })
    else
      @yachts = Yacht.where(user: current_user)
    end
  end

  def tracker
  end

  def tracker_move
  end

  def new
    @yacht = Yacht.new
  end

  def create
    @yacht = Yacht.new(yacht_params)
    @yacht.user = current_user
    if @yacht.save
      redirect_to yachts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update_location
    yacht = Yacht.find(params[:id])
    latitude = location_params[:latitude]
    longitude = location_params[:longitude]
    yacht.update(location_params)
    location_result = Geocoder.search([latitude, longitude]).first

    if location_result && location_result.city.present?
      render json: { message: location_result.city}
      yacht.update(location: location_result.city)
      #redirect_to tracker_move_path
    else
      render json: { message: "Unable to determine city from coordinates."}
      yacht.update(location: "Offshore")
    end
  end

  def update
    @yacht.user = current_user
    if @yacht.update(yacht_params)
      redirect_to yacht_path(@yacht), notice: 'Upadated successfully!', status: :see_other
    else
      render :edit
    end
  end

  def my_yachts
    @yachts = Yacht.where(user: current_user)
    render :index
  end

  def destroy
    @yacht.destroy
    redirect_to yachts_path, notice: 'Yacht was successfully destroyed!', status: :see_other
  end

  def show
  end


  def your_crew
    @users = User.all
  end

  private

  def location_params
    params.require(:yacht).permit(:latitude, :longitude)
  end

  def yacht_params
    params.require(:yacht).permit(:id,:name, :number_of_guests, :price, :location)
  end

  def set_yacht
    @yacht = Yacht.find(params[:id])
  end

  def map_yacht
    @yachts = Yacht.where(user: current_user)

    @markers = @yachts.geocoded.map do |yacht|
      {
        lat: yacht.latitude,
        lng: yacht.longitude,
        location: yacht.location,
        id: yacht.id,
        info_window_html: render_to_string(partial: "info_window", locals: {yacht: yacht}),
        marker_html: render_to_string(partial: "markers", locals: {yacht: yacht}),
        marker_html2: render_to_string(partial: "markers2", locals: {yacht: yacht})
      }
    end
  end
end
