class QuizzsController < ApplicationController
  
  before_filter :login_required, :except => [:show]

  def create
    quizz = Quizz.new
    quizz.user = @me
    quizz.question = params[:question].strip
    quizz.correct_answer = params[:correct_answer].strip
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
    @user = User.find_by_login(params[:user])
    @quizz = @user.quizzs.find(params[:id])
    if !@quizz.nil?
      @answers = @quizz.answers.paginate( :all, :per_page => ANSWERS_PER_PAGE, :page => params[:page], :order => "created_at ASC" )
      
      render :action => 'show'
    else
      render :error, :status => 404
    end
  end
  

  def add_clue
    quizz = Quizz.find_by_id(params[:id])
    if quizz && quizz.user_id = @me.id
      if quizz.add_clue!(params[:clue])
        flash[:notice] = 'Clue added correctly'
      else
        flash[:error] = 'Clue invalid'
      end
      redirect_to url_for_quizz(quizz)
    else
      render :status => 400, :text => 'Bad Request'
    end
  end
  
  
  def reveal
    quizz = Quizz.find_by_id(params[:id])
    if quizz && quizz.user_id = @me.id
      flash[:notice] = "The quizz has been revealed" if quizz.reveal!
    end
  end
  
end
