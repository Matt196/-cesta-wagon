class CreateBasketLines < ActiveRecord::Migration[5.0]
  def change
    create_table :basket_lines do |t|

      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
