class AddFieldsToReviewLinkTables < ActiveRecord::Migration
  def change
    add_column :review_link_tables, :omdb_id, :string
    add_column :review_link_tables, :reviewID, :integer
  end
end
