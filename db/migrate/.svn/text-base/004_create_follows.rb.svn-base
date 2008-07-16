class CreateFollows < ActiveRecord::Migration
  def self.up
    create_table 'follows' do |t|
      t.column 'follower_id', :integer
      t.column 'followed_id', :integer
      t.column 'created_at', :datetime
    end
  end

  def self.down
    drop_table 'follows'
  end
end