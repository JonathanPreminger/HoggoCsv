class CreateBrokers < ActiveRecord::Migration[6.0]
  def change
    create_table :brokers do |t|
      t.integer :siren

      t.timestamps
    end
  end
end
