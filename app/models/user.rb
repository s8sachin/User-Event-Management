class User < ActiveRecord::Base
	attr_accessor :password
	before_save :encrypt_password
  # validates :fname, presence: :true
  # validates :lname, presence: :true
  # validates :phone, presence: :true
  # validates :password, presence: :true
  validates :username,uniqueness: :true
  validates :email, presence: :true, uniqueness: :true
	has_many :invitations,foreign_key: :invitee_id
	has_many :events, through: :invitations
  # has_many :notifications,foreign_key: :recipient_id

def self.authenticate(email, password)
  user = find_by_email(email)
  if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    user
  else
    nil
  end
end


	def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
end

 
end
