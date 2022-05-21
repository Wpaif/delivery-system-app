class Admin < ApplicationRecord
  validates :email, format: { with: /\A[^@\s]+@sistemadefretes.com.br\z/ }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
