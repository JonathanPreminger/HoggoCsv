module ImportBroker
  require './lib/insee_api.rb'

  def import_broker_data(file)
    brokers = []
    CSV.foreach(file.path, headers: true) do |row|
      brokers << row.to_h
    end
    Broker.import brokers, recursive: true
    flash[:notice] = "Successfully imported Brokers! Begin geolocating all Brokers imported... Please refresh the page in a couple minutes"
  end

  def assign_localisation
    AssignLocalisationBrokerWorker.perform_async
  end
end
