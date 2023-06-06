require 'rubygems'
require 'rethinkdb-2.4.0.0'
include RethinkDB::Shortcuts
r.connect(:host => ENV['RETHINKDB_HOST'] || 'localhost',
          :port => ENV['RETHINKDB_PORT'] || 28015,
          :user => ENV['RETHINKDB_USERNAME'] || 'admin',
          :password => ENV['RETHINKDB_PASSWORD'] || '',
          :db => ENV['RETHINKDB_NAME'] || 'test', ).repl
r.table_create('hitPoints').run
r.table('hitPoints').insert({ 'name'=>'A' }).run
r.table('hitPoints').insert({ 'name'=>'B' }).run
r.table('hitPoints').insert({ 'name'=>'C' }).run