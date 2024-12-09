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
bot.message(start_with: "READ") do |event|;
   say = "Lump Read of the Database Content: \n";
   conn = PG.connect(ENV['DATABASE_URL'])
   # Execute SQL query   
   result = conn.exec("SELECT * FROM hitPoints");
   # Process query results
   say = say + result.inspect + "\n\n";
   result.each do |row|
     say = say + row.inspect + " \n";
     say = say + row.fetch("id").to_s + " " + row.fetch("name").to_s + " \n";
   end
   conn.close;   
   event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "tdmg") do |event|;
   alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
   letter = event.content.slice(4,1);
   #is the character found in letter valid?
   lValidity = alphabet.index(letter);
   remainder = event.content.slice(5,99);
   rValidity = remainder.index(",");
   if (lValidity != nil) && (rValidity != nil) then
      say = "Entity " + alphabet[lValidity] + " was hurt: \n";
      say = say  +  +  "  \n";
      damage = event.content.slice(5,(rValidity)).to_i;
      say = say + damage.to_s + " hurts sustained \n";
    else;
      say = "SOMETHING IS NOT RIGHT \n";
      say = say + "rValidity:" + rValidity.inspect + " \n";
      say = say + event.content;
      
    end;
   
=begin
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
=end
   event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "CREATE") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   conn.exec("DROP TABLE hitPoints");
   result = conn.exec("CREATE TABLE hitPoints (
                       id integer NOT NULL,
                       dexmod integer,
                       name varchar(31),
                       maxhp integer,
                       lowhp integer,
                       status varchar(11),
                       PRIMARY KEY (id)
                       );");
   conn.close
   event.respond result.inspect;      
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "LOAD") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   result = conn.exec("INSERT INTO hitPoints (id, name, dexmod, maxhp, lowhp, status) VALUES
                       (0, 'Alpha', 3, 10, 10, 'Dead'),
                       (1, 'Bravo', 2, 20, 20, 'Dead'),
                       (2, 'Charlie', 1, 30, 30 , 'Alive'),
                       (3, 'Delta', 0, 40, 40, 'Resting')
                       ");
   conn.close
   event.respond result.inspect;      
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
#####################################################################
bot.run