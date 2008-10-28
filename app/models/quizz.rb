class Quizz < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :winner, :class_name => 'User', :foreign_key => 'winner_id'
  has_many :answers
  
  validates_presence_of :user_id, :question, :correct_answer
  validates_associated :user
  
  #before_create :calculate_random_seed


  def is_open?
    self.winner.nil?
  end
  
  
  def is_responded?(user)
    user.answers.find_by_quizz_id( self.id )
  end
  
  def is_responded(user)
    user.answers.find_by_quizz_id( self.id ).text if !user.answers.find_by_quizz_id( self.id ).nil?
  end
  
  
  def check_answer(user, answer)
    if answer == self.correct_answer
      self.winner_id = user.id
      self.winned_at = Time.now
      self.save
    else
      response = false
    end  
  end
  
  def is_won_by?(user)
    self.winner == user
  end
  
  def close(user)
    self.closed_by = user.id
    self.closed_at = Time.now
  end
  
  def answered_by?(user)
    !self.answers.find_by_user_id(user.id).nil?
  end
  
  def answer_of(user)
    answer = self.answers.find_by_user_id(user.id)
    if !answer.nil?
      answer
    else
      nil
    end
  end
  
  
  private #private methods
    
    
end
