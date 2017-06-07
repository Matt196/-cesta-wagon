class AddColumnTimestampsToProducerReviews < ActiveRecord::Migration[5.0]
  def change
      add_column :producer_reviews, :created_at, :datetime
      add_column :producer_reviews, :updated_at, :datetime
    end
end
