class AddNameToBroker < ActiveRecord::Migration[6.0]
  def change
    add_column :brokers, :name, :string
  end
end
