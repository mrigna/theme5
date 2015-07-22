class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :timeoutable, :omniauthable, :validatable
  devise :database_authenticatable, :registerable, :rememberable, :trackable
  validates_uniqueness_of :username, {message: "%{value} already exists" }
  validates :username, presence: true

end