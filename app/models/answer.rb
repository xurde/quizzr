class Answer < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :quizz
    
  def is_ok?
    self.ok
  end
  
end
