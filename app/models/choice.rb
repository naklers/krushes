class Choice < ActiveRecord::Base
  belongs_to :user
  validates :rank, :uniqueness => { :scope => :user_id }
end
