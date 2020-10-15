module SearchBroker
  def search(search)
    result = []
    if search
      broker = Broker.find_by(siren: search)
      if broker
        redirect_to broker_path(broker.id)
      else
        redirect_to root_url, notice: "We don't have this Siren in database"
      end
    else
      result
    end
  end
end
