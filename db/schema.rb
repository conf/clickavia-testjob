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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130814120258) do

  create_table "airports", force: true do |t|
    t.integer  "city_id"
    t.string   "title"
    t.string   "iata",       limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "airports", ["city_id"], name: "index_airports_on_city_id", using: :btree
  add_index "airports", ["iata"], name: "index_airports_on_iata", using: :btree

  create_table "cities", force: true do |t|
    t.integer  "country_id"
    t.string   "title"
    t.string   "iata",       limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree
  add_index "cities", ["iata"], name: "index_cities_on_iata", using: :btree

  create_table "countries", force: true do |t|
    t.string   "title"
    t.string   "alpha2",     limit: 2
    t.string   "alpha3",     limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["alpha2"], name: "index_countries_on_alpha2", using: :btree
  add_index "countries", ["alpha3"], name: "index_countries_on_alpha3", using: :btree

  create_table "flights", force: true do |t|
    t.integer  "depart_airport_id"
    t.integer  "arrive_airport_id"
    t.string   "code",              limit: 10
    t.date     "depart_date"
    t.time     "depart_time"
    t.time     "arrive_time"
    t.string   "seats_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flights", ["depart_airport_id", "arrive_airport_id", "depart_date"], name: "index_flights_on_airports_and_date", using: :btree

end
