class InseeApi
  require 'HTTParty'

  def query
    Broker.first(25).each do |broker|
      url = "https://public.opendatasoft.com/api/records/1.0/search/?dataset=sirene_v3&q=#{broker.siren}&sort=datederniertraitementetablissement"
      request = HTTParty.get(url).to_json
      request_hash = JSON.parse(request)
      latitude = request_hash["records"][0]["fields"]["geolocetablissement"][0]
      longitude = request_hash["records"][0]["fields"]["geolocetablissement"][1]
      Broker.update(broker.id, :latitude => latitude, :longitude => longitude)
      puts "#{broker.id}"
    end
  end
end
