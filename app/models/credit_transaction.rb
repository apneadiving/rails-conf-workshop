class CreditTransaction < ActiveRecord::Base

  belongs_to :user
  belongs_to :source, polymorphic: true

  scope :for_user, ->(user) { where(user: user) }

  validates :cents, numericality: { greater_than: 0 }

end