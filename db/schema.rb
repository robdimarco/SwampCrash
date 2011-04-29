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

ActiveRecord::Schema.define(:version => 20110429163824) do

  create_table "answer_sheets", :force => true do |t|
    t.integer   "quiz_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "status",     :default => "pending", :null => false
  end

  create_table "answers", :force => true do |t|
    t.integer   "question_id", :null => false
    t.text      "value",       :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "questions", :force => true do |t|
    t.text      "value",         :null => false
    t.text      "reference_url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "quiz_questions", :force => true do |t|
    t.integer   "question_id"
    t.integer   "quiz_id"
    t.integer   "position"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.string    "name",                               :null => false
    t.text      "description"
    t.integer   "owner_id",                           :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "status",      :default => "pending"
  end

  add_index "quizzes", ["name"], :name => "index_quizzes_on_name", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer   "tag_id"
    t.integer   "taggable_id"
    t.string    "taggable_type"
    t.integer   "tagger_id"
    t.string    "tagger_type"
    t.string    "context"
    t.timestamp "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_answers", :force => true do |t|
    t.integer   "answer_sheet_id"
    t.integer   "question_id"
    t.string    "value"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "correct_answer_id"
  end

  create_table "user_tokens", :force => true do |t|
    t.integer   "user_id"
    t.string    "provider"
    t.string    "uid"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "details"
  end

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "encrypted_password",   :limit => 128
    t.string    "reset_password_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.string    "password_salt"
    t.string    "confirmation_token"
    t.timestamp "confirmed_at"
    t.timestamp "confirmation_sent_at"
    t.string    "authentication_token"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "image_url"
    t.string    "full_name"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
