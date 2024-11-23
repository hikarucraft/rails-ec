class User < ApplicationRecord
  validates :name, presence: true # this is equal to `validates(:name, presence: true)`
  validates :email, presence: true
end
