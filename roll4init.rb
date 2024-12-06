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
bot.message(start_with: "readData") do |event|;
   say = "The Data Result \n";
   conn = PG.connect(ENV['DATABASE_URL'])
   # Execute SQL query   
   result = conn.exec("SELECT * FROM hitPoints");
   # Process query results
   result.each do |row|
     say = say + row.to_s + "  " + " \n";
     say = say + "Fetch  " + row.fetch("name").to_s + "  " + row.fetch("fullhp").to_s + "  " + row.fetch("nowhp").to_s + "  \n";
     say = say + row.inspect + "   <inspected>\n";
#    say = say + row["name"].to_s + "  " + row["fullHp"].to_s + "  " + row["nowHp"].to_s + " \n";
   end

   say = say + "* " + result.values.inspect + " \n";
   (0..2).each do |x|;
     theData = result[x].values;
     say = say + " " + x.to_s + "> " + theData.inspect;
  #   say = say + theData.name.inspect.to_s + " \n";
  #   say = say + theData.fullhp.inspect.to_s  + " \n";
  #   say = say + theData.nowhp.inspect.to_s + " \n"; 
   end;

   conn.close;   
   event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "reVise") do |event|;
   say = "ALTERATION OF DATA \n";
   
   stuff = {"name" => "Alpha", "revHp" => 15}, {"name" => "Bravo", "revHp" => 5}, {"name" => "Charlie", "revHp" => 35}; 
   say = say  + stuff.inspect +  "  \n";

   conn = PG.connect(ENV['DATABASE_URL'])
   # Process updates to database
   stuff.each do |guy|;
     say = say + "INSPECTED: " + guy.inspect + " \n";
     who = guy.fetch("name").to_s;
     rHp = guy.fetch("revHp").to_i;
     say = say + "Data: " + who.to_s + "   " + rHp.to_s + "  \n";
  # Execute SQL update 
     conn.exec("UPDATE hitPoints SET nowHp = rHp WHERE name = who;");
   end
  
   conn.close;
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