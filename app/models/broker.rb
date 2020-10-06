class Broker < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'

  def self.my_import(file)
    brokers = []
    CSV.foreach(file.path) do |row|
      puts "__________"
      puts row
      brokers << Broker.new(row.to_h)
    end
    Broker.import brokers, recursive: true
  end
end
