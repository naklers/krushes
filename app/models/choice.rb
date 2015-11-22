class Choice < ActiveRecord::Base
  belongs_to :user

  validates :target_id, :uniqueness => { :scope => :user_id, message: "cannot be chosen twice... Your chances of a match won't be doubled ;-)" }
  validate :target_not_user

  def target_not_user
    if target_id==user_id
      errors.add(:target_id, "cannot be yourself")
    end
  end
end
