class CreateProducerAwards < ActiveRecord::Migration[5.0]
  def change
    create_table :producer_awards do |t|

      t.string :name
      t.string :year
      t.references :producer, foreign_key: true
    end
  end
end
