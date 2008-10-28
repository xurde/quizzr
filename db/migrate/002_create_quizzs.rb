class CreateQuizzs < ActiveRecord::Migration
  def self.up
    create_table 'quizzs' do |t|
      t.timestamps
      t.column 'user_id', :integer
      t.column 'winner_id', :integer
      t.column 'winned_at', :datetime
      t.column 'question', :string, :limit => 140
      t.column 'answer', :string, :limit => 50
      t.column 'show_pattern', :boolean, :default => false
      t.column 'reponses_per_user_limit', :integer, :default => 1
    end
  end

  def self.down
    drop_table 'quizzs'
  end
end
