class User < ApplicationRecord
    has_many :groups, through: members
    has_many :messages
    has_many :members

    # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
