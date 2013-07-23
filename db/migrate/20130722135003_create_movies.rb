class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.references :mylist, index: true
      t.string :smid

      t.timestamps
    end
  end
end
