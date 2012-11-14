class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :content
      t.string :ip
      t.text :user_agent
      t.references :photo

      t.timestamps
    end
    add_index :comments, :photo_id
  end
end
