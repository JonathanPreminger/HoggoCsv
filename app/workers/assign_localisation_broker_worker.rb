class AssignLocalisationBrokerWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    insee_data_siren = InseeApi.new
    insee_data_siren.query
  end
end
