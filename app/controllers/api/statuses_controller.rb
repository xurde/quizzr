class Api::StatusesController < Api::ApplicationController
  layout false
  before_filter :authenticate, :only => [:friends_timeline, :user_timeline]

  def friends_timeline
    @quizzs = Quizz.paginate_by_sql(
      "SELECT quizzs.* FROM quizzs LEFT OUTER JOIN follows ON quizzs.user_id = follows.followed_id
                       WHERE follows.follower_id = #{@user.id} ORDER BY quizzs.created_at DESC",
      :page => params[:page], :per_page => params[:count] || 20 )

      respond_to do |format|
        format.xml
      end
  end

  def user_timeline
    @user = User.find_by_login(params[:id])
    unless @user.nil?
      @quizzs = @user.quizzs.paginate(:all,
                                      :page => params[:page],
                                      :per_page => params[:count] || 20,
                                      :order => 'created_at DESC' )
    end

    respond_to do |format|
      format.xml
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
       @user = User.find_by_login(username)
       !User.authenticate(username, password).nil?
    end
  end

end