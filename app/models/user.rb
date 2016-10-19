require 'bcrypt'
class User < ApplicationRecord
	include BCrypt
	has_many :session , :dependent => :destroy
	has_secure_password
	validates_presence_of :name
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_presence_of :phone
	validates_presence_of :password_digest
	validates_presence_of :password_confirmation
	validates_presence_of :confirmation_link
	def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end
end
