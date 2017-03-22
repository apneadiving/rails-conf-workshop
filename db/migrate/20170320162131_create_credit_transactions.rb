class CreateCreditTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_transactions do |t|
      t.references :user, null: false
      t.integer :cents, default: 0, null: false
      t.references :source, null: false, polymorphic: true
    end
  end
end
