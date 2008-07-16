# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time
  
  before_filter :fetch_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'e714b982005547c28dd73d0c8d27127d'
    
  private
  
    def fetch_user
      @me = User.find( session[:user_id] ) if !session[:user_id].nil?
    end
  
end
