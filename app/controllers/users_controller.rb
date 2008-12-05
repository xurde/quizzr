class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  def new
    # render new.rhtml
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save if verify_recaptcha(@user)
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/home')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? :false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/home')
  end
  
  
  def show
    @user = User.find_by_login(params[:user])
    if !@user.nil?
      get_user_info(@user)
      # @can_follow = !@me.followings.find_by_followed_id(@user.id).nil?
    end
  end
  
  
  def follow
    if @me.followers.find_by_followed_id(params[:id]).nil?
      user = User.find(params[:id])
      f = Follow.new
      f.follower = @me
      f.followed = user
      flash[:notice] = 'You are now following ' + user.login if f.save
    end
    redirect_to '/' + user.login
  end
  
  
  def unfollow
    user = User.find(params[:id])
    flash[:notice] = 'You are not following ' + user.login + ' anymore' if @me.followings.find_by_followed_id( user.id ).destroy
    redirect_to '/' + user.login
  end
  
  def followers
    @user = User.find_by_login(params[:user])
    if !@user.nil?
      @followers = @user.followers
      render
    else
      render :text => 'User not valid.', :status => 404
    end
  end
  
  def followings
    @user = User.find_by_login(params[:user])
    if !@user.nil?
      @followings = @user.followings
      render
    else
      render :text => 'User not valid.', :status => 404
    end
  end
  

end
