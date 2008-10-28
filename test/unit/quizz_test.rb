require File.dirname(__FILE__) + '/../test_helper'

class QuizzTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :quizzs
  
  def test_answer_should_be_wrong
    assert !quizzs(:one).check_answer(users(:quentin), 'miss answer')
    assert_equal quizzs(:one).winner, nil
  end
  
  def test_answer_should_be_right
    assert quizzs(:one).check_answer(users(:quentin), 'answer')
    assert_equal quizzs(:one).winner, users(:quentin)
  end
  
  
  
end
