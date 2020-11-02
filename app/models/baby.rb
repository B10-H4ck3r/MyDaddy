class Baby < ApplicationRecord

  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :date_price, presence: true, length: { minimum: 5 }, allow_nil: true
  validates :text_price, presence: true, length: { minimum: 5 }, allow_nil: true
  validates :sex, presence: true, length: { maximum: 10 }, allow_nil: true
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # Returns the hash digest of the given string.
  def Baby.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Baby.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Baby.new_token
    update_attribute(:remember_digest, Baby.digest(remember_token))
    remember_digest
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def session_token
    remember_digest || remember
  end

  def feed
    Micropost.where("baby_id = ?", id)
  end

end
