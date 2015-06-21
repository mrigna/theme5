class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable, :rememberable, :trackable
  validates :username, presence: true 
end