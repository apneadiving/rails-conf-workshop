class User < ActiveRecord::Base

  attr_accessor :import_context

  after_create :send_email

  validates :email, presence: true, uniqueness: true
  validates :name,  presence: true, unless: :import_context

  def send_email
    if import_context
      AppMailer.welcome_email(self).deliver_later
    end
  end

  def affilation_earnings_cents
    CreditTransaction.for_user(self).sum(:cents)
  end

  def self.create_from_invitation(invitation)
    user = ::User.new(import_context: true)
    user.update({
      email: invitation.invitee_email
    })
    invitation.update(invitee: user)
  end
end
