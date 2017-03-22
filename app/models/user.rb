class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true

  def affilation_earnings_cents
    CreditTransaction.for_user(self).sum(:cents)
  end
end
