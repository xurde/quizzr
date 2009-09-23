class Clue < ActiveRecord::Base
  
  belongs_to :quizz
  
  validates_associated :quizz
  validates_presence_of :text
  
end
