class Invitation < ActiveRecord::Base

  belongs_to :invitee, class_name: 'User', optional: true
  belongs_to :inviter, class_name: 'User'

  before_save  :set_pay_inviter, if: ->{ accepted_changed? && accepted? }
  after_commit :pay_inviter, if: ->{ pay_inviter? }

  validates :invitee_email, presence: true

  def pay_inviter
    credit = CreditTransaction.create(user: inviter, source: self, cents: 500)
    AppMailer.notify_payment(credit).deliver_later
  end

  def pay_inviter?
    @must_pay_inviter
  end

  def set_pay_inviter
    @must_pay_inviter = true
  end
end
