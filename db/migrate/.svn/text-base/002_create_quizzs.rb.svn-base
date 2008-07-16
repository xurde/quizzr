class CreateQuizzs < ActiveRecord::Migration
  def self.up
    create_table 'quizzs' do |t|
      t.timestamps
      t.column 'open_until', :datetime
      t.column 'user_id', :integer
      t.column 'question', :string, :limit => 140
      t.column 'correct', :string, :limit => 20
      t.column 'false1', :string, :limit => 20
      t.column 'false2', :string, :limit => 20
      t.column 'false3', :string, :limit => 20
      t.column 'random_seed', :integer, :default => 0
    end
  end

  def self.down
    drop_table 'quizzs'
  end
end
