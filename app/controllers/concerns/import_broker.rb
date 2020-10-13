module ImportBroker
  def import_broker_data(file)
    brokers = []
    CSV.foreach(file.path, headers: true) do |row|
      brokers << row.to_h
    end
    Broker.import brokers, recursive: true
    redirect_to root_url, notice: "Successfully imported Brokers! Begin geolocating all Brokers imported... Please refresh the page in a couple minutes"
  end

  def assign_localisation
    AssignLocalisationBrokerWorker.perform_async
  end
end
