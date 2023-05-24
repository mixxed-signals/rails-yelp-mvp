class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show]

  # ALL restaurants -> GET /restaurants
  def index
    @restaurants = Restaurant.all
  end

  # ONE restaurant -> need dynamic id -> GET restaurant/id
  def show
  end

  # Add new restaurant -> GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # Backend creating new restaurant + saving -> need strong params -> POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_url(@restaurant), notice: "Restaurant was successfully created." }
        format.json { render :show, status: :created, location: @restaurant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # select a restaurant by its id
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # strong params to allow permissions
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end
end
