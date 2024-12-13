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
puts "--------- loading is done --------- " + Time.now(in: '-05:00').to_s;

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
###############################################################################################
###############################################################################################
bot.message(start_with: "tdmg") do |event|;
   alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; theID = 0; theName = ""; theStatus = ""; theLowHp = -9; theMaxHp = -19; health = "unknown";
   letter = event.content.slice(4,1); #4 > 3 for dmg   #NEXT LINE is the character found in letter valid?
   lValidity = alphabet.index(letter);   remainder = event.content.slice(5,99);   rValidity = remainder.index(","); # 5 > 4 for dmg
   if (lValidity != nil) && (rValidity != nil) then # valid letter and a comma is found
      damage = event.content.slice(5,(rValidity)).to_i;
      # Access the database, pull date and push results      
      conn = PG.connect(ENV['DATABASE_URL']) # build SQL command (below)
      command = "SELECT * FROM hitPoints WHERE id = " + lValidity.to_s + ";" ;
      dataVals = conn.exec(command); #execute the above command
      dataVals.each do |row|
         theID = row.fetch("id").to_i;   theName = row.fetch("name").to_s;
         theMaxHp = row.fetch("maxhp").to_i;   theLowHp = row.fetch("lowhp").to_i;
         theStatus = row.fetch("status").to_s;
      end;
      say = theName + " sustained " + damage.to_s  + " hurts.";
      theLowHp = theLowHp - damage;   percent = ( ( (theLowHp*1.00)/(theMaxHp*1.00) ) *100);
      if percent < 0 then health = "Down"; else health = "Bloody"; end;
      if percent > 50 then health = "Okay"; end;
      if percent < 0 then theStatus = "Down"; end;
      say = say + "\nand looks " + health + " and thus is " + theStatus;
      # Build SQL statement (below)
        sqlCode = "UPDATE hitPoints SET lowhp = " + theLowHp.to_s + " WHERE id = " + theID.to_s + ";";
        say = say + "\n" + sqlCode;
      # Execute SQL update 
        conn.exec(sqlCode);
    conn.close;
    else;
      say = "SOMETHING IS NOT RIGHT \n";
      say = say + "rValidity:" + rValidity.inspect + " \n";
      say = say + event.content;
    end;
   event.respond say;  
end;
###############################################################################################
###############################################################################################
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
###############################################################################################
###############################################################################################
bot.message(start_with: "LOAD") do |event|;

   conn = PG.connect(ENV['DATABASE_URL'])
   result = conn.exec("INSERT INTO hitPoints (id, name, dexmod, maxhp, lowhp, status) VALUES
                       (8, 'India', 3, 50, 50, 'Dead'),
                       (9, 'Juliette', 2, 35, 35, 'Dead'),
                       (10, 'Kilo', 1, 30, 30 , 'Alive'),
                       (11, 'Lima', 0, 40, 40, 'Resting')
                       ");
   conn.close
   event.respond result.inspect;      
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "howtoHP") do |event|;
  say = "Prepare HP command example:         \n";
  say = say + "Status : S  (Alive/Dead/Other)\n";
  say = say + "Resilience : R (0/1)          \n"
  say = say + "DEX : X                       \n";
  say = say + "HP Dice Number : N            \n";
  say = say + "HP Dice Type : T (d?)         \n";
  say = say + "Add Con HP : HP               \n";
  say = say + "Letters : ABCDEFG             \n";
  say = say + "rolltheHP:Status:R:X:N:T:HP:Letters:  \n";
  say = say + "rolltheHP:Alive :0:3:5:8:15:ABCDEFG:  \n";

  one = "```"; two =  "```";
  say = one + say + two;
  event.respond say;
end;
###############################################################################################
###############################################################################################
bot.message(start_with: "rolltheHP") do |event|;
    data = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']; say = ""; totalHP = 0; theID = ""; theStatus = ""; theDex = 0;
    theValues = [0,0,0,0];
    inputStr = event.content;
    testVal = inputStr.count(':'); 
    if testVal == 8 then; #parse and gather the data between the colons
       (0..7).each do |parts|;
          colonHere = inputStr.index(':');
          data[parts] = inputStr.slice(0,colonHere);
          inputStr = inputStr.slice!(colonHere+1,99);
       end;
       conn = PG.connect(ENV['DATABASE_URL']) # build SQL command (below)
       cN = data[7].length; # cN is the Number of Creatures
       (1..cN).each do |cnt|;
         letter = (data[7])[cnt-1,1];
           totalHP = data[6].to_i;
                  (1..(data[4].to_i)).each do |dice|;
                      totalHP = totalHP + rand(1..(data[5].to_i));
# conn.exec("INSERT INTO hitPoints (id, name, dexmod, maxhp, lowhp, status) 
                      theID = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(letter); # points to the appropriate ID for the letter
                      theStatus = data[1].to_s; #acquire the status from position [1]
                      theDex = data[3].to_s; #acquire the Dexterity Modifier from position [3]
                  end;
           sqlCode = "UPDATE hitPoints SET lowhp = " + totalHP.to_s + ", maxhp = " + totalHP.to_s + ", status = '" + 
                     theStatus + "' , dexmod = " + theDex.to_s + " WHERE id = " + theID.to_s + ";";
           say = say + "\n" + sqlCode;
         # Execute SQL update 
           conn.exec(sqlCode);           
       end;
    else;
       say = "Input Error: " + event.content;
    end; 
    conn.close;
    one = "```"; two =  "```";
    say = one + say + two;
    event.respond say ; 
end;
###############################################################################################
###############################################################################################
bot.message(start_with: "reVise") do |event|;
   say = "ALTERATION OF DATA \n";
   
   stuff = {"name" => "Alpha", "revHp" => 75},
           {"name" => "Bravo", "revHp" => 5},
           {"name" => "Charlie", "revHp" => 35}; 

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
###############################################################################################
###############################################################################################
bot.run