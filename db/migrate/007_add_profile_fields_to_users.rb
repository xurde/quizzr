class AddProfileFieldsToUsers < ActiveRecord::Migration
  
  def self.up    
    # Profile fields
    add_column :users, :name, :string, :limit => 30
    add_column :users, :website, :string, :limit => 128
    add_column :users, :gender, :string, :limit => 1
    add_column :users, :birthdate, :datetime
    add_column :users, :country, :string, :limit => 40
    add_column :users, :city, :string, :limit => 40
    add_column :users, :timezone, :integer
  end

  def self.down
    remove_column :users, :name
    remove_column :users, :website
    remove_column :users, :gender
    remove_column :users, :birthdate
    remove_column :users, :country
    remove_column :users, :city
    remove_column :users, :timezone
  end
end
