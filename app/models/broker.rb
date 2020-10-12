class Broker < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'

  scope :with_localisation, -> { where('latitude is not null') }

  def self.my_import(file)
    brokers = []
    CSV.foreach(file.path, headers: true) do |row|
      puts "__________"
      puts row
      brokers << row.to_h
    end
    Broker.import brokers, recursive: true
    assign_geolocalisation
  end

  def self.assign_geolocalisation
    puts "ssSSsAAAAAAVVVEEEEE"
    puts "ssSSsAAAAAAVVVEEEEE_______________________________________"
    insee_data_siren = InseeApi.new
    insee_data_siren.query
  end
end
