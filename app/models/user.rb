class User < ApplicationRecord
    has_many :groups, through: members
    has_many :messages
    has_many :members
end
