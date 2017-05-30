class RemoveUserNullContraintFromProducers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :producers, :user
    add_reference :producers, :user, foreign_key: true
  end
end
