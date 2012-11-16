class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :link
      t.text :description
      t.string :ip
      t.text :user_agent
      t.references :category

      t.timestamps
    end
    add_index :links, :category_id
  end
end
