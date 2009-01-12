# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 8) do

  create_table "answers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    :limit => 11
    t.integer  "quizz_id",   :limit => 11
    t.string   "text",       :limit => 50
    t.boolean  "ok"
  end

  create_table "avatars", :force => true do |t|
    t.integer "user_id",      :limit => 11
    t.integer "parent_id",    :limit => 11
    t.string  "content_type"
    t.string  "filename"
    t.string  "thumbnail"
    t.integer "size",         :limit => 11
    t.integer "width",        :limit => 11
    t.integer "height",       :limit => 11
  end

  create_table "follows", :force => true do |t|
    t.integer  "follower_id", :limit => 11
    t.integer  "followed_id", :limit => 11
    t.datetime "created_at"
  end

  create_table "quizzs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                 :limit => 11
    t.integer  "winner_id",               :limit => 11
    t.datetime "winned_at"
    t.string   "question",                :limit => 140
    t.string   "correct_answer",          :limit => 50
    t.boolean  "show_pattern",                           :default => false
    t.integer  "reponses_per_user_limit", :limit => 11,  :default => 1
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",                :limit => 40
    t.string   "salt",                            :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",                 :limit => 40
    t.datetime "activated_at"
    t.integer  "minutes_for_quizzs",              :limit => 11
    t.string   "twitter_username",                :limit => 20
    t.string   "twitter_password",                :limit => 20
    t.string   "name",                            :limit => 30
    t.string   "website",                         :limit => 128
    t.string   "gender",                          :limit => 1
    t.datetime "birthdate"
    t.string   "country",                         :limit => 40
    t.string   "city",                            :limit => 40
    t.integer  "timezone",                        :limit => 11
    t.string   "notices_by_email",                :limit => 1,   :default => "A"
    t.boolean  "notice_when_new_follower",                       :default => true
    t.boolean  "notice_when_favorited_quizz",                    :default => true
    t.boolean  "notice_when_your_quizz_solved",                  :default => true
    t.boolean  "notice_when_played_quizz_solved",                :default => false
  end

end
