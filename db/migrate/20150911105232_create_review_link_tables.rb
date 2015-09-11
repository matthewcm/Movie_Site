class CreateReviewLinkTables < ActiveRecord::Migration
  def change
    create_table :review_link_tables do |t|

      t.timestamps null: false
    end
  end
end
