class Avatar < ActiveRecord::Base
  
  belongs_to :user
  
  has_attachment :content_type => :image, 
                 :storage => :file_system,
                 :path_prefix => '/public/images/avatars/',
                 :max_size => 500.kilobytes,
                 :resize_to => '500x500>',
                 :thumbnails => { :thumb => '48x48>', :micro => '24x24>' }

  validates_as_attachment

end