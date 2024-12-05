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
bot.message(start_with: "readData") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   result = conn.exec("SELECT * FROM hitPoints");
   conn.close;
   say = " data Result \n";
   say = say + result.values.inspect;   
   event.respond say;      
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "create") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   conn.exec("DROP TABLE hitPoints");
   result = conn.exec("CREATE TABLE hitPoints (
                       name varchar(20),
                       fullHp integer,
                       nowHp integer)");
  
   conn.close
   event.respond result.inspect;      
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "addData") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   result = conn.exec("INSERT INTO hitPoints (name, fullHp, nowHp) VALUES
                       ('Alpha', 10, 10),
                       ('Bravo', 20, 20),
                       ('Charlie', 30, 30)");

   conn.close
   event.respond result.inspect;      
end;

#####################################################################
bot.run