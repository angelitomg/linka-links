class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :filename
      t.string :ip
      t.text :user_agent
      t.references :category

      t.timestamps
    end
    add_index :photos, :category_id
  end
end
