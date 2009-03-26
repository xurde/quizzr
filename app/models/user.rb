require 'digest/sha1'
class User < ActiveRecord::Base
  
  has_one  :avatar
  has_many :quizzs
  has_many :answers
  has_many :won_quizzs, :class_name => 'Quizz', :foreign_key => 'winner_id'
  has_many :followers, :class_name => 'Follow', :foreign_key => 'followed_id'
  has_many :followings, :class_name => 'Follow', :foreign_key => 'follower_id'
  
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..20, :message => "Username must be between 3 and 20 chars of length"
  validates_length_of       :email,    :within => 8..100, :message => "Email must be between 8 and 20 chars of length"
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  validates_format_of       :login, :with => /^[a-zA-Z][a-z0-9A-Z_]{2,19}$/, :on => :create, :message => "Username must begin with a letter and use only standard characters, numbers and '_'" #empieza por un char seguido de 2 a 19 caracteres, números o '_'
  
  before_save :encrypt_password, :normalize_login
  before_create :make_activation_code
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation, :activation_code, :name, :email, :website, :gender, :birthdate, :country, :city, :notices_by_email, :notice_when_new_follower, :notice_when_your_quizz_solved, :notice_when_played_quizz_solved

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  def active?
    # the existence of an activation date means the account is active.
    !activated_at.nil?
  end

  # Returns true if the user has just been activated.
  def pending?
    @activated
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) #:first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    if u && u.active?
      u.authenticated?(password) ? u : nil
    end
    
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end
  
  #added by xurde
  
  def is_followed_by?(user)
    self.followers.find_by_follower_id(user.id).nil?
  end
  
  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
    
    def make_activation_code
      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
    
    def normalize_login
      self.login.downcase!
    end
end
