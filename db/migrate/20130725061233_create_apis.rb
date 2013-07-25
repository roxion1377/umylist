class CreateApis < ActiveRecord::Migration
  def change
    create_table :apis do |t|
      t.references :user, index: true
      t.string :key

      t.timestamps
    end
  end
end
