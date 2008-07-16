class QuizzsController < ApplicationController
  
  before_filter :login_required, :except => [:show]

  def create
    quizz = Quizz.new
    quizz.user = @me
    quizz.question = params[:question]
    quizz.correct = params[:correct]
    quizz.false1 = params[:false1] if !params[:false1].nil?
    quizz.false2 = params[:false2] if !params[:false2].nil?
    quizz.false3 = params[:false3] if !params[:false3].nil?
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
    @quizz = Quizz.find( params[:id] )
    if @quizz.user.login == params[:user]
      @responses = @quizz.responses
      render :action => 'show'
    else
      render :error, :status => 404
    end
  end
  
  
  
end
