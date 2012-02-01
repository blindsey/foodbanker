# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120201071846) do

  create_table "reports", :force => true do |t|
    t.string   "year",                                    :null => false
    t.string   "quarter",                                 :null => false
    t.string   "region",                                  :null => false
    t.string   "agency_name",                             :null => false
    t.string   "program_name",                            :null => false
    t.string   "person_name",                             :null => false
    t.string   "phone_number",                            :null => false
    t.integer  "new_clients",              :default => 0, :null => false
    t.integer  "age_0_17",                 :default => 0, :null => false
    t.integer  "age_18_59",                :default => 0, :null => false
    t.integer  "age_60_plus",              :default => 0, :null => false
    t.integer  "gender_male",              :default => 0, :null => false
    t.integer  "gender_female",            :default => 0, :null => false
    t.integer  "homeless_individuals",     :default => 0, :null => false
    t.integer  "homeless_families",        :default => 0, :null => false
    t.integer  "homeless_chronic",         :default => 0, :null => false
    t.integer  "female_head_of_household", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.datetime "locked_at"
    t.string   "name",                                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
