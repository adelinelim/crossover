class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates :email, presence: true
  # validates :password, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
end
