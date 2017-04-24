class Invitation < ActiveRecord::Base

  belongs_to :invitee, class_name: 'User', optional: true
  belongs_to :inviter, class_name: 'User'

  validates :invitee_email, presence: true

  def accept
    self.accepted = true
    self
  end
end
