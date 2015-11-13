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

  mount_uploader :photo, PhotoUploader

  # Define batch import
  require 'csv'
  def self.import(csv_file)
    CSV.foreach(csv_file.path, headers: true) do |row|
      user_hash = row.to_hash # exclude the price field
      user = User.where(email: user_hash["email"])
      # check to see if the user already exists in the database. if it does, it will then attempt to update the existing product. If not, create a new user and send password config email
      if user.count == 1
        user.first.update_attributes(user_hash)
      else
        User.create(user_hash).send_reset_password_instructions
      end
    end # end CSV.foreach
  end
end
