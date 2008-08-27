class AddTwitterFields < ActiveRecord::Migration
  
  def self.up
    add_column :users, :twitter_username, :string, :limit => 20
    add_column :users, :twitter_password, :string, :limit => 20

  end

  def self.down
    remove_column :users, :twitter_username
    remove_column :users, :twitter_password
  end
  
end

