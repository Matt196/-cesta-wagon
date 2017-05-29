class CreateProductAwards < ActiveRecord::Migration[5.0]
  def change
    create_table :product_awards do |t|

      t.string :name
      t.string :year
      t.references :product, foreign_key: true
    end
  end
end
