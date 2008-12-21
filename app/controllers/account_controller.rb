class AccountController < ApplicationController

  def index
  end
  
  def password_recover   
  end
  
  def password_sending
    user = User.find_by_email(params[:email])
    if !user.nil?
      
    else
      flash[:error] = "No user found with that email. Sorry."
      redirect_to :action => 'password_recover'
    end  
  end

  def settings
    @user = User.find(@me)
  end

  def update_avatar
    avatar = @me.avatar || Avatar.new( :user => @me )
    flash[:notice] = 'Avatar was successfully updated' if avatar.update_attributes( params[:avatar] )
    redirect_to :action => 'settings'
    
  end
  
  def update_twitter_profile
    user = User.find(@me)
    
    begin 
      Twitter::Base.new( params[:user][:twitter_username], params[:user][:twitter_password] ).verify_credentials
      user.twitter_username = params[:user][:twitter_username]
      user.twitter_password = params[:user][:twitter_password]
      flash[:notice] = 'Twitter account was verified and saved correctly' if user.save
      redirect_to :action => 'settings'
    rescue
      flash[:error] = "Twitter username and/or pass invalid"
      redirect_to :action => 'settings'
    end
  end
  
end
