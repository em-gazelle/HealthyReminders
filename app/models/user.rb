class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true

  # Setup accessible (or protected) attributes for your model
  attr_accessor :password
  attr_accessible :email, :nickname, :phone_number, :password, :password_confirmation, :remember_me, :id


end
