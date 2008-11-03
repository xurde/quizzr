# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  
  before_filter :fetch_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e714b982005547c28dd73d0c8d27127d'
    
  def get_user_info(user)
      @quizzs = user.quizzs.find(:all, :order => 'created_at DESC' )
      # logger.info 'QUIZZS == ' + @quizzs.size.to_s
      @answers = user.answers.find(:all, :order => 'created_at DESC' )
      # logger.info 'ANSWERS == ' + @answers.size.to_s
      @won = user.answers.find(:all, :conditions => ["ok = 1"] )
      # logger.info 'WON == ' + @won.size.to_s
      @followings = user.followings
      @followers = user.followers
  end
    
  private
  
    def fetch_user
      @me = User.find( session[:user_id] ) if !session[:user_id].nil?
    end    
    
  
end
