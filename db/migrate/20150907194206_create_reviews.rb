class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :omdb_id

      t.timestamps null: false
    end
  end
end
