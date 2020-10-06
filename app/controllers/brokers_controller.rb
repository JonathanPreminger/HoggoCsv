class BrokersController < ApplicationController
  def index
    @brokers = Broker.all
  end

  def import
    Broker.my_import(params[:file])
    redirect_to root_url, notice: "Successfully imported data!!!"
  end
end
