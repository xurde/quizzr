class AddNotificationFieldsForClues < ActiveRecord::Migration

  def self.up
    # Profile fields
    add_column :users, :notice_when_new_clues, :boolean, :default => true
  end

  def self.down
    remove_column :users, :notice_when_new_clues
  end

end
