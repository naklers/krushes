class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable

  # Has many choices that need destroying if user is destroyed
  has_many :choices, dependent: :destroy

  def password_required?
    new_record? ? false : super
  end

  def self.all_except(user)
    where.not(id: user)
  end

end
