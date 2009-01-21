class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  before_filter :login_required, :only => [ :follow, :remove ]

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
      logger.info "DEBUG ==> sending mail registration mail"
      #UserObserver Override
      #UserMailer.deliver_signup_notification(@user)
      redirect_back_or_default('/home')
      flash[:notice] = "Thanks for signing up!"
    else
      render :action => 'new'
    end
  end

  def activate
    user = User.find_by_activation_code(params[:activation_code])
    if !user.nil?
      logger.info "CURRENT USER >> #{user.inspect}"
      user.activate
      flash[:notice] = "Account activated!"
    end
    if @me.nil?
      redirect_to login_path
    else
      redirect_to :controller => 'home'
    end
  end
  
  
  def show #(quizzs)
    @user = User.find_by_login(params[:user])
    if !@user.nil?
      get_user_info(@user)
      @quizzs = @user.quizzs.paginate(:all, :page => params[:page], :per_page => QUIZZS_PER_PAGE, :order => 'created_at DESC' )
    end
  end
  
  def show_answers 
    @user = User.find_by_login(params[:user])
    if !@user.nil?
      #for user_info
      get_user_info(@user)
      #@can_follow = !@me.followings.find_by_followed_id(@user.id).nil?
      @quizzs = Quizz.paginate_by_sql( "SELECT quizzs.* FROM quizzs LEFT OUTER JOIN answers ON quizzs.id = answers.quizz_id WHERE answers.user_id = #{ @user.id } ORDER BY quizzs.created_at DESC", 
                                            :page => params[:page], :per_page => QUIZZS_PER_PAGE )
      
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
  
  
  def remove #unfollow
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
