class AnswersController < ApplicationController

  def create
    quizz = Quizz.find( params[:id] )
    if !quizz.nil? & quizz.is_open?
        #TODO Check that user can answer this quizz
        answer = Answer.new
        answer.quizz = quizz
        answer.user = @me
        answer.text = params[:answer]
        answer.ok = @answer_ok = quizz.response(@me, params[:answer])
        answer.save
        if @answer_ok
          flash[:notice] = "That was exact"
        else
          flash[:notice] = "That's not right"
        end
        redirect_to :controller => 'quizzs', :action => 'show', :user => quizz.user.login, :id => quizz.id
    end
  end
  
end
