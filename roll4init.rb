#bot.message(start_with:"cash") do |event|;
#
require 'discordrb';
require 'pg';
require 'yaml';
require 'date';
require 'securerandom';
include Math;


puts "Cranking it up for another go!";

##########  Configuration  ########
junk = YAML.load(File.read("roll4initData.yml"));
token = junk[0]+junk[1]+junk[2];

prefix = "!" # Your bot's prefix
owner = 924129933586997308  # the Application ID

puts;
puts "          Roll 4 Init will be active soon ";
puts;

initiativeBase = YAML.load(File.read("initiativeBase.yml"));
puts initiativeBase.inspect;
puts "--------- done ---------";

bot = Discordrb::Bot.new token: token

bot.message(start_with:"hello") do |event|;
  puts "*** within the hello method ***";
  say = "I heard you";
   event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "fuck") do |event|;
  say = "Here Come the read results \n";
  event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "SHIT") do |event|;
   say = "Here Come da Judge: \n";

   conn = PG.connect(
     host: ENV['HEROKU_POSTGRESQL_HOST'],
     database: ENV['HEROKU_POSTGRESQL_DATABASE'],
     username: ENV['HEROKU_POSTGRESQL_USERNAME'],
     password: ENV['HEROKU_POSTGRESQL_PASSWORD']
   )

   #result = conn.exec("SELECT * FROM my_table")
   wut = conn.inspect;
   conn.close


   event.respond wut;      
end;
##################################################################################################################
##################################################################################################################

#####################################################################
bot.run