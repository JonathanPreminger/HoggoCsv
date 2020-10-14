class AddAdressToBroker < ActiveRecord::Migration[6.0]
  def change
    add_column :brokers, :address, :string
  end
end
