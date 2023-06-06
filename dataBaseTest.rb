require 'rubygems'
require 'rethinkdb'
include RethinkDB::Shortcuts
r.connect(:host => ENV['RETHINKDB_HOST'] || 'localhost',
          :port => ENV['RETHINKDB_PORT'] || 28015,
          :user => ENV['RETHINKDB_USERNAME'] || 'admin',
          :password => ENV['RETHINKDB_PASSWORD'] || '',
          :db => ENV['RETHINKDB_NAME'] || 'test', ).repl
r.table_create('hitPoints').run
r.table('hitPoints').insert({ 'name'=>'A', 'current'=>'100', 'max'=>'100' }).run
r.table('hitPoints').insert({ 'name'=>'B', 'current'=>'95', 'max'=>'95' }).run
r.table('hitPoints').insert({ 'name'=>'C', 'current'=>'90', 'max'=>'90' }).run
r.table('hitPoints').insert({ 'name'=>'D', 'current'=>'85', 'max'=>'85' }).run
r.table('hitPoints').insert({ 'name'=>'E', 'current'=>'80', 'max'=>'80' }).run
r.table('hitPoints').insert({ 'name'=>'F', 'current'=>'75', 'max'=>'75' }).run
r.table('hitPoints').insert({ 'name'=>'G', 'current'=>'100', 'max'=>'100' }).run
r.table('hitPoints').insert({ 'name'=>'H', 'current'=>'100', 'max'=>'100' }).run
r.table('hitPoints').insert({ 'name'=>'I', 'current'=>'100', 'max'=>'100' }).run
r.table('hitPoints').insert({ 'name'=>'J', 'current'=>'100', 'max'=>'100' }).run
r.table('hitPoints').insert({ 'name'=>'K', 'current'=>'100', 'max'=>'100' }).run
r.table('hitPoints').insert({ 'name'=>'L', 'current'=>'100', 'max'=>'100' }).run