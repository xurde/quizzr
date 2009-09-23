class Answer < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :quizz
  
  #validates_uniqueness_of :quizz_id, :scope => [ :user_id ], :message => "You already answered this quizz"
    
  def is_ok?
    self.ok
  end
  
  private
  
  def validate_on_create
    unless self.quizz.is_open?
      errors.add_to_base("That quizz is already solved")
    end
    
    
  end
  
end
