class InseeApi
  require 'HTTParty'

  def query
    Broker.last(5).each do |broker|
      url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=sirene_v3&q=#{broker.siren}&sort=datederniertraitementetablissement"
      request = HTTParty.get(url).to_json
      request_hash = JSON.parse(request)
      latitude = request_hash["records"][0]["fields"]["geolocetablissement"][0]
      puts latitude
      Broker.update(broker.id, :latitude => latitude)
      longitude = request_hash["records"][0]["fields"]["geolocetablissement"][1]
      puts longitude
      Broker.update(broker.id, :longitude => longitude)
    end
    puts "apres"
    puts Broker.last(5).inspect
  end
end
