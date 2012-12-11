class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :link
      t.text :token
      t.text :description
      t.text :ip
      t.text :user_agent
      t.references :category
	  t.references :user

      t.timestamps
    end
    add_index :links, :category_id, :user_id
  end
end
