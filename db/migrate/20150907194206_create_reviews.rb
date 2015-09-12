class CreateReviews < ActiveRecord::Migration
  def change
      create_table "reviews", force: :cascade do |t|
        t.string   "title"
        t.string   "movie_id"
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
        t.text     "body"
  end
    end
  end
end
