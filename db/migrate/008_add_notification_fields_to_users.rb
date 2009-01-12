class AddNotificationFieldsToUsers < ActiveRecord::Migration

  def self.up
    # Profile fields
    add_column :users, :notices_by_email, :string, :limit => 1, :default => 'A'
    add_column :users, :notice_when_new_follower, :boolean, :default => true
    add_column :users, :notice_when_favorited_quizz, :boolean, :default => true
    add_column :users, :notice_when_your_quizz_solved, :boolean, :default => true
    add_column :users, :notice_when_played_quizz_solved, :boolean, :default => false
  end

  def self.down
    remove_column :users, :notices_by_email
    remove_column :users, :notice_when_new_follower
    remove_column :users, :notice_when_favorited_quizz
    remove_column :users, :notice_when_your_quizz_solved
    remove_column :users, :notice_when_played_quizz_solved
  end

end
