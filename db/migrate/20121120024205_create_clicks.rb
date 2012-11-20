class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
	  t.references :link
	  t.text :ip
	  t.text :user_agent
      t.timestamps
    end
  end
end
