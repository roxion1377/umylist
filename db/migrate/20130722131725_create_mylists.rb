class CreateMylists < ActiveRecord::Migration
  def change
    create_table :mylists do |t|
      t.references :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
