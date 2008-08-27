class Quizz < ActiveRecord::Base
  
  belongs_to :user
  has_many :responses
  
  validates_presence_of :user_id, :question, :correct
  validates_associated :user
  
  before_create :calculate_random_seed, :calculate_time_open


  def is_open?
    self.open_until > Time.now if !self.open_until.nil?
  end
  
  
  def is_responded?(user)
    user.responses.find_by_quizz_id( self.id )
  end
  
  def is_responded(user)
    user.responses.find_by_quizz_id( self.id ).text if !user.responses.find_by_quizz_id( self.id ).nil?
  end
  
  def is_single?
    self.false1.empty?
  end
  
  
  def status( user = nil )
    if user.nil?
      if self.is_open?
        return 'open'
      else
        return 'closed'
      end
    else
      if self.is_open?
        return 'open'
      else
        if self.is_responded?(user)
          return 'responded'
        else
          return 'closed'
        end  
      end
    end
  end
  
  def is_ok(user)
    resp = user.responses.find_by_quizz_id(self.id)
    if !resp.nil?
      if resp.ok
        'right'
      else
        'wrong'
      end
    else
      if self.is_open?
        ''
      else
        'blank'
      end
    end
  end
 
  def is_response_ok?(response)
     ( response.to_i - self.random_seed ) == 1
  end
  
  
  def derandomized_option(response)
    option( response.to_i - self.random_seed )
  end
  
  
  def options
    ans = [ self.correct ]
    for i in 1..3
      ans << self.send('false' + i.to_s) if !(self.send('false' + i.to_s).nil? or self.send('false' + i.to_s).empty? )
    end
    return ans
  end
  
  
  def randomized_options
    self.options.shift_to_right( self.random_seed )
  end
  
  
  def option(ord)
    if ord == 0
      self.correct
    else
      self.send( 'false' + ord.to_s )
    end
  end
  
  
  private #private methods
    
    def calculate_time_open
      self.open_until = self.created_at.advance( :minutes => self.user.minutes_for_quizzs || 10 )
    end
    
    def calculate_random_seed
      self.random_seed = Time.now.to_f.hash.modulo( self.options.size )
    end
    
end
