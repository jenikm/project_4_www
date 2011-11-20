class AddCountryIdIndexOnUsers < ActiveRecord::Migration
  def up
    add_index :users, :country_id
  end

  def down
    remove_index :users, :column => :country_id
  end
end
