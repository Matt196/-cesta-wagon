class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|

      t.string :name
      t.string :description
      t.integer :price
      t.references :producer, foreign_key: true
    end
  end
end
