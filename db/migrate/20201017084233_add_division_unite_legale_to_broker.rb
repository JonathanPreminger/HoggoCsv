class AddDivisionUniteLegaleToBroker < ActiveRecord::Migration[6.0]
  def change
    add_column :brokers, :division_unite_legale, :string
  end
end
