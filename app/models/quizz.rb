class Quizz < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :winner, :class_name => 'User'
  has_many :answers
  has_many :clues
  
  validates_presence_of :user_id, :question, :correct_answer
  validates_associated :user
  
  after_create :post_to_user_twitter

  def is_open?
    self.closed_at.nil?
  end
  
  def is_solved?
    !self.winner_id.nil?
  end
  
  def is_won_by?(user)
    self.winner == user
  end
  
  def is_responded?(user)
    !self.response_by(user).nil?
  end
  
  def just_solved?
    @solved
  end

  def just_revealed?
    @revealed
  end
  
  def just_new_clue?
    @new_clue
  end
  
  def response_by(user)
    last_answer = self.answers.find(:first, :conditions => "user_id = #{user.id}" , :order => 'created_at DESC')
    if last_answer && (last_answer.created_at >= self.updated_at)
      last_answer
    else
      nil
    end
  end
  
  def answered_by?(user)
    !self.response_by(user).nil?
  end
  

  def validate_response(answer) #Validates answers
    answer.downcase.normalize == self.correct_answer.downcase.normalize #Compares normalized strings
  end

  def win!(user) #Validates answers
      @solved = true
      self.winner_id = user.id
      self.closed_at = Time.now
      self.save
  end
  
  # def close!(user)
  #   self.closed_by = user.id
  #   self.closed_at = Time.now
  # end
  
  def reveal!
    @revealed = true
    self.closed_at = Time.now
    self.save
  end
  
  
  def add_clue!(clue_text)
    clue = Clue.new
    clue.quizz = self
    clue.text = clue_text
    if clue.save
      @new_clue = true
      self.updated_at = Time.now
      self.save
      return true
    else
      return false
    end
  end
  
  
  private #private methods
    
    def post_to_user_twitter
      if !self.user.twitter_username.nil?
        logger.info("DEBUG >>> begin quizzing for #{self.user.login}")
        twitter = Twitter::Base.new(self.user.twitter_username, self.user.twitter_password)
        twitter.post( question_crop(self.question, 100) + " ♣ http://quizzr.net/#{self.user.login}/quizz/#{self.id.to_s}")
        logger.info("DEBUG >>> #{self.user.login} quizzed #{self.question}")
      end
    end
    
    def question_crop(question, limit)
      if question.size > limit
        question[0,(limit - 4)] << '...'
      else
        question
      end
    end
    
end
