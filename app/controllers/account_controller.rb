class AccountController < ApplicationController

  def index
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
    if !params[:user][:twitter_username].nil? & !params[:user][:twitter_password].nil?
      user.twitter_username = params[:user][:twitter_username]
      user.twitter_password = params[:user][:twitter_password]
      flash[:notice] = 'Twitter account was updated' if user.save
      redirect_to :action => 'settings'
    else
      flash[:error] = "Twitter username and password can't be blank"
      redirect_to :action => 'settings'
    end
  end
  
end
