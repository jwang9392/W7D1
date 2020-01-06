class User < ApplicationRecord

  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  
  # after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credential(username, password)
    user = User.find_by(user_name: username)
    # debugger
    return user if user && user.is_password?(password) 
    nil
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.generate_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    # debugger
    restored_hash = BCrypt::Password.new(self.password_digest)
    restored_hash.is_password?(password)
    # debugger
  end
end

# Instance Method Summary
# collapse
# #==(secret) ⇒ Object (also: #is_password?)
# Compares a potential secret against the hash.
