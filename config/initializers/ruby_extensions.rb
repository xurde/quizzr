class String
  
  def normalize
    ActiveSupport::Inflector::transliterate(self).to_s
  end
  
end