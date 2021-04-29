require "bundler"
Bundler.require

require_relative "../lib/character.rb"
require_relative "../db/seed.rb"

DB = {:conn => SQLite3::Database.new("db/simpsons.db")}

DB[:conn].results_as_hash = true

Character.create_table