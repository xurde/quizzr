class CreateClues < ActiveRecord::Migration

  def self.up
    create_table 'clues' do |t|
      t.timestamps
      t.column 'quizz_id', :integer
      t.column 'text', :string, :limit => 50
    end
  end

  def self.down
    drop_table 'clues'
  end
  
end
