class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :orders, :dependent => :destroy
  has_many :products, :dependent => :destroy
  validates :name, presence: true
  validates :email, uniqueness: true

  def unpaid_orders
    orders.where(paid: false)
  end

  #check this code above it should be wrong

  def unpaid_orders?
    unpaid_orders.any?
  end
end
