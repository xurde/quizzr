# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include ExceptionNotifiable
  
  helper :all # include all helpers, all the time
  
  before_filter :fetch_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e714b982005547c28dd73d0c8d27127d'
    
  def get_user_info(user)
      @user[:quizzs] = quizzs = user.quizzs.count
      # logger.info 'QUIZZS == ' + @quizzs.size.to_s
      @user[:answers] = answers = user.answers.count
      # logger.info 'ANSWERS == ' + @answers.size.to_s
      @user[:won] = won =  user.answers.count( :conditions => ["ok = true"] )
      # logger.info 'WON == ' + @won.size.to_s
      @user[:ratio] = (won.to_i * 100) / answers.to_i if !answers.zero?
      @user[:followings] = user.followings
      @user[:followers] = user.followers
  end
  
  def render_errorpage
    render :file => 'public/404.html', :status => 404 #Hacer página especial para user not found
  end
  
  
  def self.mail_weekly_newsletter(user_login)
    user = User.find_by_login(user_login)
    if user
      most_quizzer_users = User.find_by_sql("SELECT users.login, count(*) AS num_quizzs FROM users INNER JOIN quizzs ON users.id = quizzs.user_id WHERE quizzs.created_at >'2009-03-29' AND quizzs.created_at <'2009-04-06' GROUP BY users.id ORDER BY num_quizzs DESC LIMIT 10")
      most_answered_quizzs = Quizz.find_by_sql("SELECT users.login, users.id, quizzs.*, count(*) AS num_answers FROM users INNER JOIN quizzs ON users.id = quizzs.user_id JOIN answers ON answers.quizz_id = quizzs.id WHERE quizzs.created_at >'2009-03-29' AND quizzs.created_at <'2009-04-06' GROUP BY users.id, quizzs.id ORDER BY num_answers DESC LIMIT 10")
      Newsletter.deliver_weekly_newsletter(user, most_quizzer_users, most_answered_quizzs)
    end
  end
  
  
    
  private
  
    def fetch_user
      @me = User.find( session[:user_id] ) if !session[:user_id].nil?
    end    
    
  
end


class String
  
  def to_ascii_unicode
    converter = Iconv.new('ASCII//IGNORE//TRANSLIT', 'UTF-8')
    converter.iconv(self).unpack('U*').select{ |cp| cp < 127 }.pack('U*')
  end
  
end