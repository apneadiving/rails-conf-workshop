# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170320162131) do

  create_table "credit_transactions", force: :cascade do |t|
    t.integer "user_id",                 null: false
    t.integer "cents",       default: 0, null: false
    t.string  "source_type",             null: false
    t.integer "source_id",               null: false
    t.index ["source_type", "source_id"], name: "index_credit_transactions_on_source_type_and_source_id"
    t.index ["user_id"], name: "index_credit_transactions_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.integer "inviter_id",                    null: false
    t.integer "invitee_id"
    t.string  "invitee_email",                 null: false
    t.boolean "accepted",      default: false
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
  end

end
