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
    
  private
  
    def fetch_user
      @me = User.find( session[:user_id] ) if !session[:user_id].nil?
    end    
    
  
end