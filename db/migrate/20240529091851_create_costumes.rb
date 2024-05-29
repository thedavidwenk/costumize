class CreateCostumes < ActiveRecord::Migration[7.1]
  def change
    create_table :costumes do |t|
      t.string :name
      t.string :category
      t.string :size
      t.string :description
      t.integer :price_per_day

      t.timestamps
    end
  end
end
