class AddColumnToBasketLines < ActiveRecord::Migration[5.0]
  def change
    add_column :basket_lines, :qte, :inetger
  end
end
