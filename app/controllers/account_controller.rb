class AccountController < ApplicationController

  before_filter :login_required, :except => [ :password_recover, :password_sending ]
  
  def index
    redirect_to :action => 'profile'
  end
  
  def profile
    @user = User.find(@me)
  end
  
  def avatar
    @user = User.find(@me)
  end
  
  def apps
    @user = User.find(@me)
  end

  def update_profile
    user = @me
    if user.update_attributes( params[:user] )
      flash[:notice] = 'Profile was successfully updated'
    else
      flash[:notice] = 'Unable to update your profile'
    end
    redirect_to :action => 'profile'
    
  end


  def update_avatar
    avatar = @me.avatar || Avatar.new( :user => @me )
    if avatar.update_attributes( params[:avatar] )
      flash[:notice] = 'Avatar was successfully updated'
    else
      flash[:notice] = 'Unable to update your avatar'
    end
    redirect_to :action => 'avatar'
    
  end
  
  def update_twitter_profile
      user = User.find(@me)
      begin
        twitter = Twitter::Base.new( params[:user][:twitter_username], params[:user][:twitter_password] )
      rescue
        flash[:error] = "Error while trying to connect to Twitter"
      end
      if !twitter.nil?
        begin
          twitter.verify_credentials
          user.twitter_username = params[:user][:twitter_username]
          user.twitter_password = params[:user][:twitter_password]
          flash[:notice] = 'Twitter account was verified and connected correctly' if user.save
        rescue
          flash[:error] = "Twitter username and/or pass invalid"
        end
      end
      redirect_to :action => 'apps'
  end
  
  def reset_twitter_profile
      user = User.find(@me)
      if !user.nil?
        user.twitter_username = nil
        user.twitter_password = nil
        flash[:notice] = 'Your twitter account was disconnected' if user.save
      else
        flash[:error] = "Error disconnecting your Twitter account"
      end
      redirect_to :action => 'apps'
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
  
end
