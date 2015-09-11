class AddIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :omdb_id, :string
  end
end
