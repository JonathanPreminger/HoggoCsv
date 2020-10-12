class AddLatitudeToBroker < ActiveRecord::Migration[6.0]
  def change
    add_column :brokers, :latitude, :float
  end
end
