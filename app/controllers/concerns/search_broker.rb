module SearchBroker
  def search(search)
    result = []
    if search
      siren = Broker.find_by(siren: search)
      if siren
        redirect_to broker_path(siren.id)
      else
        redirect_to root_url, notice: "We don't have this Siren in database"
      end
    else
      result
    end
  end
end
