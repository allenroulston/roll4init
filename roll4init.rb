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
#puts initiativeBase.inspect;
puts "--------- loading is done ---------";

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
bot.message(start_with: "READ") do |event|;
   say = "The Data Content: FETCHING: \n";
   conn = PG.connect(ENV['DATABASE_URL'])
   # Execute SQL query   
   result = conn.exec("SELECT * FROM hitPoints");
   # Process query results
   say = say + result.inspect;
   result.each do |row|
     say = say + row.inspect;
#     say = say + row.fetch("ID").to_s + " " + row.fetch("Name").to_s + " " + row.fetch("MaxHp").to_s + " " + row.fetch("LowHp").to_s + "  \n";
   end
   conn.close;   
   event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "reVise") do |event|;
   say = "ALTERATION OF DATA \n";
   
   stuff = {"name" => "Alpha", "revHp" => 75}, {"name" => "Bravo", "revHp" => 5}, {"name" => "Charlie", "revHp" => 35}; 
   say = say  + stuff.inspect +  "  \n";

   conn = PG.connect(ENV['DATABASE_URL'])
   # Process updates to database
   stuff.each do |guy|;
     say = say + "INSPECTED: " + guy.inspect + " \n";
     who = guy.fetch("name").to_s;
     rHp = guy.fetch("revHp").to_i;
   # Build SQL statement (below)
     sqlCode = "UPDATE hitPoints SET nowHp = '" + rHp.to_s + "' WHERE name = '" + who + "';";
     say = say + sqlCode;
   # Execute SQL update 
     conn.exec(sqlCode);
   end

   conn.close;
   event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "CREATE") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   conn.exec("DROP TABLE hitPoints");
   result = conn.exec("CREATE TABLE hitPoints (
                       ID integer NOT NULL,
                       Name varchar(26),
                       MaxHp integer,
                       LowHp integer,
                       PRIMARY KEY (ID)
                       );");
   conn.close
   event.respond result.inspect;      
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "LOAD") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   result = conn.exec("INSERT INTO hitPoints (ID, Name, MaxHp, LowHp) VALUES
                       (0, 'Alpha', 10, 10),
                       (1, 'Bravo', 20, 20),
                       (2, 'Charlie', 30, 30),
                       (3, 'Delta', 40, 40)
                       ");
   conn.close
   event.respond result.inspect;      
end;

#####################################################################
bot.run