class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.references :inviter, null: false
      t.references :invitee
      t.string :invitee_email, null: false
      t.boolean :accepted, default: false
    end
  end
end
