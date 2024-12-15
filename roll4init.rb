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
   result = conn.exec("SELECT * FROM hitPoints ORDER BY id");
   # Process query results
   # say = say + result.inspect + "\n\n";
   result.each do |row|
     # say = say + row.inspect + " \n";
     say = say + row.fetch("id").to_s + " " + row.fetch("name").to_s + " \n";
   end
   conn.close;   
   event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "INITREAD") do |event|;
   say = "Lump Read of the Database Content: \n";
   conn = PG.connect(ENV['DATABASE_URL'])
   # Execute SQL query   
   result = conn.exec("SELECT * FROM activeInit");
   # Process query results
   say = say + result.inspect + "\n\n";
   result.each do |row|
     say = say + row.inspect + " \n";
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
   #conn.exec("DROP TABLE hitPoints");
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
bot.message(start_with: "CREATE-AI") do |event|;
   conn = PG.connect(ENV['DATABASE_URL'])
   conn.exec("DROP TABLE activeInit");
   result = conn.exec("CREATE TABLE activeInit (
                       id integer NOT NULL,
                       name varchar(31),
                       dex integer,
                       adv integer,
                       status varchar(11),
                       mixtape varchar(11),
                       final integer,
                       PRIMARY KEY (id)
                       );");
   conn.close
   event.respond result.inspect;      
end;
###############################################################################################
###############################################################################################
bot.message(start_with: "LOAD") do |event|;
  #                       (0, 'Alpha', 3, 50, 50, 'Dead'),
  #                       (1, 'Bravo', 2, 35, 35, 'Dead'),
  #                       (2, 'Charlie', 1, 30, 30 , 'Dead'),
  #                       (3, 'Delta', 3, 50, 50, 'Dead'),
  #                       (4, 'Echo', 2, 35, 35, 'Dead'),   
  #                       (5, 'Foxtrot', 3, 50, 50, 'Dead'),
  #                       (6, 'Golf', 2, 35, 35, 'Dead'),
  #                       (7, 'Hotel', 0, 40, 40, 'Dead'),
  #                       (8, 'India', 1, 30, 30 , 'Dead'),
  #                       (9, 'Juliette', 3, 50, 50, 'Dead'),
  #                       (11, 'Kilo', 2, 35, 35, 'Dead'),
  #                       (12, 'Lima', 1, 30, 30 , 'Dead'),
  #                       (13, 'Mike', 0, 40, 40, 'Dead'),
   conn = PG.connect(ENV['DATABASE_URL'])
   result = conn.exec("INSERT INTO hitPoints (id, name, dexmod, maxhp, lowhp, status) VALUES
                       (14, 'November', 3, 50, 50, 'Dead'),
                       (15, 'Oscar', 2, 35, 35, 'Dead'),
                       (16, 'Papa', 1, 30, 30 , 'Dead'),
                       (17, 'Quebec', 3, 50, 50, 'Dead'),
                       (18, 'Romeo', 2, 35, 35, 'Dead'),   
                       (19, 'Sierra', 3, 50, 50, 'Dead'),
                       (20, 'Tango', 2, 35, 35, 'Dead'),
                       (21, 'Uniform', 0, 40, 40, 'Dead'),
                       (22, 'Victor', 1, 30, 30 , 'Dead'),
                       (23, 'Whiskey', 3, 50, 50, 'Dead'),
                       (24, 'X-Ray', 2, 35, 35, 'Dead'),
                       (25, 'Yankee', 1, 30, 30 , 'Dead'),
                       (26, 'Zulu', 0, 40, 40, 'Dead')
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
##################################################################################################################
##################################################################################################################
bot.message(start_with: "%d") do |event|;
  say = "Making peeps DEAD \n";
  alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  # establish a connection with the database
  conn = PG.connect(ENV['DATABASE_URL'])
  goLive = event.content.slice(2,49);
  (0..25).each do |check|
      if goLive.index(alpha[check]) != nil then;
        theID = check;
        # Build SQL statement (below)
          sqlCode = "UPDATE hitPoints SET status = '" + "Dead" + "' WHERE id = " + theID.to_s + ";\n";
          say = say + sqlCode;
        # Execute SQL update 
          conn.exec(sqlCode); 
      end;
  end;
  conn.close;
  event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "%a") do |event|;
  say = "Making peeps ALIVE \n";
  alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  # establish a connection with the database
  conn = PG.connect(ENV['DATABASE_URL'])
  goLive = event.content.slice(2,49);
  (0..25).each do |check|
      if goLive.index(alpha[check]) != nil then;
        theID = check;
        # Build SQL statement (below)
          sqlCode = "UPDATE hitPoints SET status = '" + "Alive" + "' WHERE id = " + theID.to_s + ";\n";
          say = say + sqlCode;
        # Execute SQL update 
          conn.exec(sqlCode); 
      end;
  end;
  conn.close;
  event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "%x") do |event|; #DEXTERITY ASSIGNMENT
  say = "Assigning peeps DEX \n";
  alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  inputStr = event.content.slice(2,50);
  colonHere = inputStr.index(':');
  if colonHere == nil then;
     say = "Command Format: !d-2:ABC\nTake note of the colon.";
  else;
         conn = PG.connect(ENV['DATABASE_URL'])
         goDex = inputStr.slice(0,colonHere).to_i;
         goPeep = inputStr.slice(colonHere,49);
         (0..25).each do |check|
             if goPeep.index(alpha[check]) != nil then;
               theID = check;
               # Build SQL statement (below)
                 sqlCode = "UPDATE hitPoints SET dexmod = " + goDex.to_s + " WHERE id = " + theID.to_s + ";\n";
                 say = say + sqlCode;
               # Execute SQL update 
                 conn.exec(sqlCode); 
             end;
         end;
     conn.close;
  end;
  event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "%r") do |event|;
    event.message.delete; say = "";
    if event.user.nick != nil;  theUser = event.user.nick;  else;  theUser = event.user.name;  end;
    if ( (theUser == "Allen the GM") || (theUser == "Allen.G.M.") || (theUser == "MaxAllen") ) then;
      #mixtape used to ensure ties are handled
      mixTape = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","0","1","2","3","4","5","6","7","8","9","A","B"].shuffle;      
      alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      data = Array.new(37) { ['id', 'name', 'dex', 'adv', 'status', 'mixtape', 'final' ] } 
    # open the connection to the databse
      conn = PG.connect(ENV['DATABASE_URL'])
         # Execute SQL query   
         cursor = conn.exec("SELECT * FROM hitPoints WHERE status = 'Alive' ");
         count = 0;
         # Process query results
                cursor.each do |doc|
                      data[count][0] = doc["id"];
                      data[count][1] = doc["name"];
                      data[count][2] = doc["dexmod"].to_i;
                      data[count][3] = doc["maxhp"].to_i;
                      data[count][4] = doc["status"];
                      data[count][5] = mixTape[count];
                      data[count][6] = 0;
                      count = count + 1;
                end;
      howMany = (data.length)-1;
      (0..howMany).each do |x|;
          if data[x][3] == 0 then;
             data[x][6] = rand(1..20) + (data[x][2].to_i);
          else;
             data[x][6] = [rand(1..20),rand(1..20)].max + (data[x][2].to_i);
          end;       
      end;

      # sorting the list of creatures
      temp = Array.new(37) { ['id', 'name', 'dex', 'adv', 'status', 'mixtape', 'final' ] }; # temp sort storage
          (0..(howMany*howMany)).each do |loop|;
             (0..howMany-1).each do |x|;
                if data[x][6] < data[x+1][6] then;
                   (0..36).each do |t|;
                       temp[t] = data[x]; # move all of [x] by [t] to the temporary storage 
                   end;
                   (0..36).each do |t|;
                       data[x] = data[x+1]; # move all of [x+1] by [t] into [x] by [t]
                   end;
                   (0..36).each do |t|;
                       data[x+1] = temp[t];  # move all of temp [t] into [x+1] by [t] to complete the sort exchange
                   end;
                end;
             end;
          end;
          #now account for the same scores where the higher DEX score will go first.
      temp = Array.new(37) { ['id', 'name', 'dex', 'adv', 'status', 'mixtape', 'final' ] }; # temp sort storage
          (1..(howMany*howMany)).each do |loop|;
             (1..howMany-1).each do |x|;
                if data[x][6] == data[x+1][6] then;
                   if (data[x][2].to_s) < (data[x+1][2].to_s)   # DEX mod is on position #2
                      (0..36).each do |t|;
                          temp[t] = data[x]; # move all of [x] by [t] to the temporary storage 
                      end;
                      (0..36).each do |t|;
                          data[x] = data[x+1]; # move all of [x+1] by [t] into [x] by [t]
                      end;
                      (0..36).each do |t|;
                          data[x+1] = temp[t];  # move all of temp [t] into [x+1] by [t] to complete the sort exchange
                      end;
                   end;
                end;
             end; 
          end;
          #now account for the same scores and same DEX score, use the random character column to determine who will go first.
          temp = Array.new(37) { ['id', 'name', 'dex', 'adv', 'status', 'mixtape', 'final' ] }; # temp sort storage
          (1..(howMany*howMany)).each do |loop|;
            (1..howMany-1).each do |x|;
                if (data[x][6] == data[x+1][6]) && (data[x][2] == data[x+1][2]) then;
                   if data[x][5].ord > data[x+1][5].ord   # random character is in position 5 
                      (0..36).each do |t|;
                          temp[t] = data[x]; # move all of [x] by [t] to the temporary storage 
                      end;
                      (0..36).each do |t|;
                          data[x] = data[x+1]; # move all of [x+1] by [t] into [x] by [t]
                      end;
                      (0..36).each do |t|;
                          data[x+1] = temp[t];  # move all of temp [t] into [x+1] by [t] to complete the sort exchange
                      end;
                   end;
                end;
             end; 
          end;
    # drop existing database and create fresh activeInit database
    conn.exec("DROP TABLE activeInit");   
    result = conn.exec("CREATE TABLE activeInit (
                        id integer NOT NULL,
                        name varchar(31),
                        dexmod integer,
                        adv integer,
                        status varchar(11),
                        mixtape varchar(11),
                        final integer,
                        PRIMARY KEY (id)
                        );");
    # add ALIVE entries to the database
    conn = PG.connect(ENV['DATABASE_URL'])
    idVal = 0;
    (0..36).each do |zed|
       if data[zed][4] == "Alive" then  # we need to test each entry to ensure the status = Alive 
#           say = say + "\n" + idVal.to_s + "  " + data[zed][1].to_s + "  " + data[zed][2].to_s;
#           say = say + "\n> " + idVal.to_s + " " + data[zed][6].to_s + " " + data[zed][1].to_s + " " + data[zed][2].to_s + " " + data[zed][4].to_s;
#           r.table('activeInit').insert({ :id => idVal, :final => data[zed][6], :name => data[zed][1], :dex => data[zed][2], :status => data[zed][4] }).run;
           sqlCode = "INSERT INTO activeInit (id, name, dexmod, adv, status, mixtape, final) VALUES (" +
           idVal.to_s + ", '" + data[zed][1].to_s + "', " + data[zed][2].to_s + ", " + data[zed][3].to_s +
           ", '" + data[zed][4] + "', '" + data[zed][5] + "', " + data[zed][6].to_s + ")";
           # say = say + "\n" + sqlCode.slice(78,40);
           result = conn.exec(sqlCode)
           idVal = idVal + 1;
       end;
    end;
    
    say = say + "\n" + "**Ready to Rumble.**  Initiative rolling and sorting is complete. ";
 
          event.respond say; 
          else; 
              event.respond "Who are you?";
          end;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "%n") do |event|; #next initiative revealed
  say = ""; # start with nothing in variable say
  one = "```"; two =  "```";
  conn = PG.connect(ENV['DATABASE_URL'])
      # Build SQL statement (below)
        sqlCode = "SELECT * FROM activeInit LIMIT 1";
      # Execute SQL CODE 
        result = conn.exec(sqlCode);
        goNogo = result.ntuples.to_i;
        if goNogo != 0 then;
           result.each do |item|
                 theID = item.fetch("id").to_s;
                 theName = item.fetch("name").to_s;
                 theFinal = item.fetch("final").to_s;
                 say = say + one + "(i" + theID +")[" + theFinal +"] **" + theName + "** has initiative" + two;
                 sqlCode = "DELETE FROM activeInit WHERE id = " + theID + ";";
                 conn.exec(sqlCode);
           end;
        else;
           say = say + "\n** END OF THE COMBAT ROUND**";
        end;
        
  conn.close;
  event.respond say;
end;       
###############################################################################################
###############################################################################################
bot.run