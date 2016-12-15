class Admin < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 7 }
end
