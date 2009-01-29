class Quizz < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :winner, :class_name => 'User', :foreign_key => 'winner_id'
  has_many :answers
  
  validates_presence_of :user_id, :question, :correct_answer
  validates_associated :user
  
  after_create :post_to_twitter


  def is_open?
    self.winner.nil?
  end
  
  def solved?
    @solved
  end
  
  def is_responded?(user)
    user.answers.find_by_quizz_id( self.id )
  end
  
  def responded_for(user)
    user.answers.find_by_quizz_id( self.id ).text if !user.answers.find_by_quizz_id( self.id ).nil?
  end
  
  
  def response(user, answer) #Validates answers
    if answer.downcase.to_ascii_unicode == self.correct_answer.downcase.to_ascii_unicode #Compares downcased and ascii strings
      self.winner_id = user.id
      self.winned_at = Time.now
      @solved = self.save
    else
      false
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
    
    def post_to_twitter
      if !self.user.twitter_username.nil?
        twitter = Twitter::Base.new(self.user.twitter_username, self.user.twitter_password)
        twitter = Twitter::Base.new('quizzr', 'sebadoh')
        twitter.post(self.user.login + ' quizzed: ' + self.question + " - http://quizzr.net/#{self.user.login}/quizz/#{self.id.to_s}")
      end
    end
    
end
