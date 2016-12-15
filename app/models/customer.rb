require "bcrypt"

class Customer < ActiveRecord::Base
  # validates :firstname, presence: true
  # validates :lastname, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, length: { minimum: 7 }

  # def password
  #   binding.pry
  #   @password ||= Password.new(password_hash)
  # end
  #
  # def password=(new_password)
  #   binding.pry
  #   return if new_password.blank?
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end
end
