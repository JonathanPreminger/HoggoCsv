module ImportBroker

  def import_broker_data(file)
    number_of_brokers_before_import = Broker.all.count
    brokers = []
    CSV.foreach(file.path, headers: true) do |row|
      brokers << row.to_h
    end
    brokers_supposed_to_be_imported = brokers.size
    Broker.import brokers, recursive: true
    brokers_actually_imported = Broker.all.count - number_of_brokers_before_import
    if brokers_supposed_to_be_imported == brokers_actually_imported
      redirect_to root_url, notice: "Successfully imported Brokers! Begin geolocating all Brokers imported... Please refresh the page in a couple minutes for the mapping"
    else
      redirect_to root_url, notice: "#{brokers_supposed_to_be_imported - brokers_actually_imported} brokers havn't been imported on #{brokers_actually_imported}... Please refresh the page in a couple minutes for the mapping"
    end
  end

  def assign_localisation
    AssignLocalisationBrokerWorker.perform_async
  end
end
