module HomeHelper
  
 def class_for_option( quizz, option )
    if option == quizz.correct 
      response 'correct'
    elsif option == quizz.is_responded( @me )
      response 'mistaken'
    else
      response ''
    end
 end
  
end
