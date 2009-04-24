class HomeController < ApplicationController
  
  before_filter :login_required

  def index
    
    if !@me.nil?
      @user = @me
    else
      redirect_to login_path #chapufixing for sessions missing
    end
    
    case params[:filter]
    when nil
      @quizzs = Quizz.paginate_by_sql( "SELECT DISTINCT quizzs.* FROM quizzs INNER JOIN follows ON (quizzs.user_id = follows.followed_id OR quizzs.user_id = #{@user.id}) WHERE follows.follower_id = #{@user.id} ORDER BY quizzs.created_at DESC",
                                            :page => params[:page], :per_page => QUIZZS_PER_PAGE )
    when 'open'
      @quizzs = Quizz.paginate_by_sql( "SELECT DISTINCT quizzs.* FROM quizzs INNER JOIN follows ON (quizzs.user_id = follows.followed_id) LEFT OUTER JOIN answers ON quizzs.id = answers.quizz_id WHERE follows.follower_id = #{@user.id} AND quizzs.closed_at is NULL AND answers.id IS NULL ORDER BY quizzs.created_at DESC",
                                            :page => params[:page], :per_page => QUIZZS_PER_PAGE )
    when 'won'
      @quizzs = @user.won_quizzs.paginate( :page => params[:page], :per_page => QUIZZS_PER_PAGE, :order => 'quizzs.created_at DESC' )
    when 'failed'
      @quizzs = Quizz.paginate_by_sql( "SELECT quizzs.* FROM quizzs INNER JOIN answers ON quizzs.id = answers.quizz_id WHERE answers.user_id = #{@user.id} AND answers.ok = 0 ORDER BY quizzs.created_at DESC",
                                            :page => params[:page], :per_page => QUIZZS_PER_PAGE, :order => 'quizzs.created_at DESC' )
    else
      render :error, :status => 404
    end
    get_user_info(@user)
  end
  
end
