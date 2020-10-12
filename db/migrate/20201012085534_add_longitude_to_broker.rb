class AddLongitudeToBroker < ActiveRecord::Migration[6.0]
  def change
    add_column :brokers, :longitude, :float
  end
end
