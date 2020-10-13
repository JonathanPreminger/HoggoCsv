class BrokersController < ApplicationController
  before_action :set_broker, only: [:show, :edit, :update, :destroy]
  include SearchBroker
  include ImportBroker

  def index
    @results = search(params[:search])
    @brokers = Broker.all
    @locations = []
    Broker.with_localisation.find_each {|broker| @locations << {lat: broker.latitude,lng: broker.longitude}}
  end

  def import
    import_broker_data(params[:file])
    assign_localisation
  end

  def show
    @results = search(params[:search])
  end

  def new
    @broker = Broker.new
  end

  def edit
  end

  def create
    @broker = Broker.new(broker_params)

    respond_to do |format|
      if @broker.save
        format.html { redirect_to @broker, notice: 'Broker was successfully created.' }
        format.json { render :show, status: :created, location: @broker }
      else
        format.html { render :new }
        format.json { render json: @broker.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @place.update(broker_params)
        format.html { redirect_to @broker, notice: 'Broker was successfully updated.' }
        format.json { render :show, status: :ok, location: @broker }
      else
        format.html { render :edit }
        format.json { render json: @broker.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @broker.destroy
    respond_to do |format|
      format.html { redirect_to brokers_url, notice: 'Broker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def set_broker
    @broker = Broker.find(params[:id])
  end

  def broker_params
    params.require(:broker).permit(:siren, :latitude, :longitude)
  end
end
