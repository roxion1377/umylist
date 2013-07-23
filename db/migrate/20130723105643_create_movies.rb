class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.references :mylist, index: true
      t.references :user, index: true
      t.string :sm_id
      t.string :thread_id

      t.timestamps
    end
  end
end
