class QuizzsController < ApplicationController
  
  before_filter :login_required, :except => [:show]

  def create
    quizz = Quizz.new
    quizz.user = @me
    quizz.question = params[:question]
    quizz.correct_answer = params[:correct_answer]
    if quizz.save
      flash[:notice] = "Quizz sent"
    else
      flash[:error] = "Error creating quizz"
    end
    redirect_to :controller => 'home'
  end

  def destroy
  end
  
  
  def show
    @user = User.find_by_login( params[:user] )
    #logger.info 'USER :::: ' + @user.id.to_s if !@user.nil?
    @quizz = @user.quizzs.find( params[:id] )
    #logger.info 'QUIZZ :::: ' + @quizz.id.to_s if !@quizz.nil?
    if !@quizz.nil?
      @answers = @quizz.answers.paginate( :all, :per_page => 20, :page => params[:page], :order => "created_at DESC" )
      
      #@can_answer = (@quizz.is_open?) & (@quizz.answers.find_by_user_id(@me).nil?) & (@quizz.user.id != @me.id) if !@me.nil?
      
      render :action => 'show'
    else
      render :error, :status => 403
    end
  end
  
  
  
end
