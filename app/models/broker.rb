class Broker < ApplicationRecord
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'csv'
  require 'activerecord-import/base'

  validates :siren, presence: true, allow_nil: false
  scope :with_localisation, -> { where('latitude is not null') }

  def self.import_broker_data(file)
    brokers = []
    CSV.foreach(file.path, headers: true) do |row|
      brokers << row.to_h
    end
    Broker.import brokers, recursive: true
    #AssignLocalisationBrokerWorker.perform_async
    insee_data_siren = InseeApi.new
    insee_data_siren.query
  end

end
