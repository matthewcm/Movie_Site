class AddFieldsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movieTitle, :string
  end
end
