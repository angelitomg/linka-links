class AddTokenColumnToLinks < ActiveRecord::Migration
  def change
    add_column :links, :token, :text

  end
end
