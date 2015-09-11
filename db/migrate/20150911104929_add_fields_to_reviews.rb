class AddFieldsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :body, :text
    add_column :reviews, :reviewID, :integer
  end
end
