class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table 'answers' do |t|
      t.timestamps
      t.column 'user_id', :integer
      t.column 'quizz_id', :integer
      t.column 'text', :string, :limit => 50
      t.column 'ok', :boolean
    end
  end

  def self.down
    drop_table 'answers'
  end
  
end
