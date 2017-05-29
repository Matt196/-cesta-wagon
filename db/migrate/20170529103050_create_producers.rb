class CreateProducers < ActiveRecord::Migration[5.0]
  def change
    create_table :producers do |t|

      t.string :name
      t.string :address
      t.string :zipcode
      t.string :city
      t.text :description
      t.string :phone
      t.string :mobile_phone
      t.string :company_email
      t.string :category
      t.references :user, null: false, foreign_key: true, index: true
    end
  end
end
