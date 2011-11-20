class AddGenderAgeCountryIdRegisteredAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :integer
    add_column :users, :age, :integer
    add_column :users, :country_id, :integer
    add_column :users, :registered_at, :date
  end
end
