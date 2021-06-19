class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attachment :profile_image
  
  has_many :books, dependent

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
