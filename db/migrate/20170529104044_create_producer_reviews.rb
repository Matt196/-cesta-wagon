class CreateProducerReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :producer_reviews do |t|

      t.text :content
      t.integer :mark
      t.references :user, foreign_key: true
      t.references :producer, foreign_key: true
    end
  end
end
