class DropPlacesTable < ActiveRecord::Migration[6.0]
    def up
      drop_table :places
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
end
