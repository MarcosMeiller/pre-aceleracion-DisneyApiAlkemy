# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_31_142720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_movies", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "character_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["character_id"], name: "index_character_movies_on_character_id"
    t.index ["movie_id"], name: "index_character_movies_on_movie_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "weight"
    t.text "history"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genremovies", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_genremovies_on_genre_id"
    t.index ["movie_id"], name: "index_genremovies_on_movie_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.text "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.text "image"
    t.string "creation_date"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "character_movies", "characters"
  add_foreign_key "character_movies", "movies"
  add_foreign_key "genremovies", "genres"
  add_foreign_key "genremovies", "movies"
end
