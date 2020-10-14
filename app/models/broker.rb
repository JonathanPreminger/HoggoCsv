class Broker < ApplicationRecord
  include Sidekiq::Worker
  sidekiq_options retry: false
  require 'csv'
  require 'activerecord-import/base'

  validates :siren, presence: true, allow_nil: false, :length => { :minimum => 9, :maximum => 9 }
  validates_uniqueness_of :siren
  scope :with_localisation, -> { where('latitude is not null') }

end
