class AccountController < ApplicationController

  before_filter :login_required, :except => [ :password_recover, :password_forgotten, :password_reset, :password_reset_change ]
  
  def index
    redirect_to :action => 'profile'
  end
  
  def profile
    @user = User.find(@me)
  end

  def password
    @user = User.find(@me)
  end
  
  def notices
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
      flash[:notice] = 'Your profile was updated.'
    else
      flash[:error] = 'Unable to update your profile.'
    end
    redirect_to :action => 'profile'
  end
  
  def update_password
    user = @me
    if user.update_attributes( params[:user] )
      flash[:notice] = 'Password was successfully updated.'
    else
      flash[:error] = 'Unable to update your password.'
    end
    redirect_to :action => 'password'
  end


  def update_avatar
    avatar = @me.avatar || Avatar.new( :user => @me )
    if avatar.update_attributes( params[:avatar] )
      flash[:notice] = 'Avatar was successfully updated.'
    else
      flash[:error] = 'Unable to update your avatar.'
    end
    redirect_to :action => 'avatar'
    
  end
  
  def update_notices
    user = @me
    if user.update_attributes( params[:user] )
      flash[:notice] = 'Notices were updated.'
    else
      flash[:error] = 'Unable to update your notices config.'
    end
    redirect_to :action => 'notices'
  end
  
  def update_twitter_profile
      user = User.find(@me)
      begin
        twitter = Twitter::Base.new( params[:user][:twitter_username], params[:user][:twitter_password] )
      rescue
        flash[:error] = "Error while trying to connect to Twitter."
      end
      if !twitter.nil?
        begin
          twitter.verify_credentials
          user.twitter_username = params[:user][:twitter_username]
          user.twitter_password = params[:user][:twitter_password]
          flash[:notice] = 'Twitter account was verified and connected correctly.' if user.save
        rescue
          flash[:error] = "Twitter username and/or pass invalid."
        end
      end
      redirect_to :action => 'apps'
  end
  
  def reset_twitter_profile
      user = User.find(@me)
      if !user.nil?
        user.twitter_username = nil
        user.twitter_password = nil
        flash[:notice] = 'Your twitter account was disconnected.' if user.save
      else
        flash[:error] = "Error disconnecting your Twitter account."
      end
      redirect_to :action => 'apps'
  end
  
  
  # Forgotten password methods
    
  def password_recover
  end
  
  def password_forgotten
    user = User.find_by_email(params[:email])
    if !user.nil?
      user.activation_code = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{user.login}--")
      user.save
      UserMailer.deliver_forgotten_password(user)
      flash[:notice] = "A password reset link was sent to your mail."
      redirect_to login_path
    else
      flash[:error] = "No user found with that email. Sorry."
      redirect_to :action => 'password_recover'
    end
  end
  
  
  def password_reset
    user = User.find_by_email(params[:email])
    if !user.nil? && user.activation_code == params[:token]
      @email = user.email
      @token = user.activation_code
    else
      flash[:error] = "Your email and token are invalid. You'll need to restart the process."
      redirect_to :action => 'password_recover'
    end
    
  end
  
  def password_reset_change
    user = User.find_by_email(params[:email])
    if !user.nil? && user.activation_code == params[:token]
      if params[:password] == params[:password_confirmation]
        #guardar nueva pass
        user.update_attribute( :password, params[:password] )
        user.update_attribute( :activation_code, '' )
        redirect_to login_path
      else
        flash[:error] = "Password and confirmation do not match."
        redirect_to :back
      end
    else
      flash[:error] = "Your email and token are invalid. You'll need to restart the process."
      redirect_to :action => 'password_recover'
    end
  
    
  end
  
end
