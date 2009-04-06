class AddNewsletterFieldsToUsers < ActiveRecord::Migration

  def self.up
    # Profile fields
    add_column :users, :daily_newsletter, :boolean, :default => false
    add_column :users, :weekly_newsletter, :boolean, :default => true
    add_column :users, :monthly_newsletter, :boolean, :default => true
  end

  def self.down
    remove_column :users, :daily_newsletter
    remove_column :users, :weekly_newsletter
    remove_column :users, :monthly_newsletter
  end

end