class Response < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :quizz
  
  
  def is_ok
    if self.quizz.is_open?
      ''
    else
      if self.ok
        'right'
      else
        'wrong'
      end
    end
  end
  
end
