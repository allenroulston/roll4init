#bot.message(start_with:"cash") do |event|;
#
require 'discordrb';
require 'rethinkdb';
require 'yaml';
require 'date';
require 'securerandom';
include Math;
include RethinkDB::Shortcuts

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
   r.connect(:host => ENV['RETHINKDB_HOST'] || 'localhost',
             :port => ENV['RETHINKDB_PORT'] || 28015,
             :user => ENV['RETHINKDB_USERNAME'] || 'admin',
             :password => ENV['RETHINKDB_PASSWORD'] || '',
             :db => ENV['RETHINKDB_NAME'] || 'test', ).repl
   r.table_drop('hitPoints').run
   r.table_create('hitPoints').run
   r.table('hitPoints').insert({ :name=>'A', 'val'=>[100,95] }).run
   r.table('hitPoints').insert({ :name=>'B', 'val'=>[95,90] }).run
   r.table('hitPoints').insert({ :name=>'C', 'val'=>[90,85] }).run
   r.table('hitPoints').insert({ :name=>'D', 'val'=>[85,80] }).run
   r.table('hitPoints').insert({ :name=>'E', 'val'=>[80,75] }).run
   r.table('hitPoints').insert({ :name=>'F', 'val'=>[75,70] }).run
   r.table('hitPoints').insert({ :name=>'G', 'val'=>[100,95] }).run
   r.table('hitPoints').insert({ :name=>'H', 'val'=>[95,90] }).run
   r.table('hitPoints').insert({ :name=>'I', 'val'=>[90,85] }).run
   r.table('hitPoints').insert({ :name=>'J', 'val'=>[85,80] }).run
   r.table('hitPoints').insert({ :name=>'K', 'val'=>[80,75] }).run
   r.table('hitPoints').insert({ :name=>'L', 'val'=>[75,70] }).run
   r.table('hitPoints').insert({ :name=>'M', 'val'=>[100,95] }).run
   r.table('hitPoints').insert({ :name=>'N', 'val'=>[95,90] }).run
   r.table('hitPoints').insert({ :name=>'O', 'val'=>[90,85] }).run
   r.table('hitPoints').insert({ :name=>'P', 'val'=>[85,80] }).run
   r.table('hitPoints').insert({ :name=>'Q', 'val'=>[80,75] }).run
   r.table('hitPoints').insert({ :name=>'R', 'val'=>[75,70] }).run
   r.table('hitPoints').insert({ :name=>'S', 'val'=>[100,95] }).run
   r.table('hitPoints').insert({ :name=>'T', 'val'=>[95,90] }).run
   r.table('hitPoints').insert({ :name=>'U', 'val'=>[90,85] }).run
   r.table('hitPoints').insert({ :name=>'V', 'val'=>[85,80] }).run
   r.table('hitPoints').insert({ :name=>'W', 'val'=>[80,75] }).run
   r.table('hitPoints').insert({ :name=>'X', 'val'=>[75,70] }).run
   r.table('hitPoints').insert({ :name=>'Y', 'val'=>[100,95] }).run
   r.table('hitPoints').insert({ :name=>'Z', 'val'=>[95,90] }).run
     
   bob = r.table('hitPoints').get_all(:name).run
   say = say + bob.inspect;
   event.respond say;      
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "DMG") do |event|;
     say = "This is a DAMAGE result \n";
  letter = event.content.slice(3,1);
  hurt = event.content.slice(5,9).to_i;
  say = say + letter + "   " + hurt.to_s + "\n";
  r.connect(:host => ENV['RETHINKDB_HOST'] || 'localhost',
            :port => ENV['RETHINKDB_PORT'] || 28015,
            :user => ENV['RETHINKDB_USERNAME'] || 'admin',
            :password => ENV['RETHINKDB_PASSWORD'] || '',
            :db => ENV['RETHINKDB_NAME'] || 'test', ).repl
  bob = r.table('hitPoints').filter({'name' => letter }).run #(conn)
  say = say + bob.inspect;
  event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "piss") do |event|;
  letter = event.content.slice(4,1);
  say = "Here Come the read results \n";
    event.respond say;
  r.connect(:host => ENV['RETHINKDB_HOST'] || 'localhost',
            :port => ENV['RETHINKDB_PORT'] || 28015,
            :user => ENV['RETHINKDB_USERNAME'] || 'admin',
            :password => ENV['RETHINKDB_PASSWORD'] || '',
            :db => ENV['RETHINKDB_NAME'] || 'test', ).repl
  bob = r.table('hitPoints').filter({'name' => letter }).run #(conn)
  bob.each{|data| p document}
     say = say + p.to_s + "\n";
  end;
  event.respond say;  
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "gmhelp") do |event|;
  say = "Command List \n"
  say = say + "!r : roll new initiatives \n";
  say = say + "!n : show next initiative \n\n";
  say = say + "!d@ : mark Entity Dead \n";
  say = say + "   where @ = A or B or C... \n";
  say = say + "!a@ : mark Entity Alive \n";
  say = say + "   where @ = A or B or C... \n";
  say = say + "!x#@ : assign Dex Mod # for @ \n";
  say = say + "   where @ = A or B or C... \n";
  say = say + "!s  : show all Entities \n";
   event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "!r") do |event|;
  event.message.delete; 
  if event.user.nick != nil;  theUser = event.user.nick;  else;  theUser = event.user.name;  end;
  if theUser != "SayWhat" then;
     initArray = YAML.load(File.read("initiativeBase.yml"));
     #mixtape used to ensure ties are handled
     mixTape = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","$","@","%","&","!","(",")"].shuffle;
     howMany = (initArray.length)-1;
     (0..howMany).each do |x|;
         d20Roll = rand(1..20);
         initArray[x][4]= (initArray[x][1].to_i + d20Roll).to_s;
         initArray[x][5] = mixTape[x];     
     end;
   # sorting the list of creatures
   (0..(howMany*howMany)).each do |loop|;
     (0..howMany-1).each do |x|;
       if initArray[x][4].to_i < initArray[x+1][4].to_i then;
         temp0 = initArray[x][0]; temp1 = initArray[x][1]; temp2 = initArray[x][2]; temp3 = initArray[x][3]; temp4 = initArray[x][4]; temp5 = initArray[x][5];
         initArray[x][0]=initArray[x+1][0]; initArray[x][1]=initArray[x+1][1]; initArray[x][2]=initArray[x+1][2];
         initArray[x][3]=initArray[x+1][3]; initArray[x][4]=initArray[x+1][4]; initArray[x][5]=initArray[x+1][5];
         initArray[x+1][0] = temp0; initArray[x+1][1] = temp1; initArray[x+1][2] = temp2;
         initArray[x+1][3] = temp3; initArray[x+1][4] = temp4; initArray[x+1][5] = temp5;
       end;
     end;
   end; #loop outside the sorting by only the resulting initiative roll
   
   #now account for the same scores where the higher DEX score will go first.
   (0..(howMany*howMany)).each do |loop|;
     (0..howMany-1).each do |x|;
       if initArray[x][4].to_i == initArray[x+1][4].to_i then;
            if initArray[x][1].to_i < initArray[x+1][1].to_i   # DEX mod is on position #1
              temp0 = initArray[x][0]; temp1 = initArray[x][1]; temp2 = initArray[x][2]; temp3 = initArray[x][3]; temp4 = initArray[x][4]; temp5 = initArray[x][5];
              initArray[x][0]=initArray[x+1][0]; initArray[x][1]=initArray[x+1][1]; initArray[x][2]=initArray[x+1][2];
              initArray[x][3]=initArray[x+1][3]; initArray[x][4]=initArray[x+1][4]; initArray[x][5]=initArray[x+1][5];
              initArray[x+1][0] = temp0; initArray[x+1][1] = temp1; initArray[x+1][2] = temp2;
              initArray[x+1][3] = temp3; initArray[x+1][4] = temp4; initArray[x+1][5] = temp5;
            end;
       end;
     end; 
   end;

   #now account for the same scores and same DEX score, use the random character column to determine who will go first.
   (0..(howMany*howMany)).each do |loop|;
     (0..howMany-1).each do |x|;
       if (initArray[x][4].to_i == initArray[x+1][4].to_i) && (initArray[x][1].to_i == initArray[x+1][1].to_i) then;
            if initArray[x][5].ord < initArray[x+1][5].ord   # random character is in position #
              temp0 = initArray[x][0]; temp1 = initArray[x][1]; temp2 = initArray[x][2]; temp3 = initArray[x][3]; temp4 = initArray[x][4]; temp5 = initArray[x][5];
              initArray[x][0]=initArray[x+1][0]; initArray[x][1]=initArray[x+1][1]; initArray[x][2]=initArray[x+1][2];
              initArray[x][3]=initArray[x+1][3]; initArray[x][4]=initArray[x+1][4]; initArray[x][5]=initArray[x+1][5];
              initArray[x+1][0] = temp0; initArray[x+1][1] = temp1; initArray[x+1][2] = temp2;
              initArray[x+1][3] = temp3; initArray[x+1][4] = temp4; initArray[x+1][5] = temp5;
            end;
       end;
     end; 
   end;

   data = "---" + "\n";
   (0..howMany).each do |x|;
     theZero = initArray[x][0].to_s;
     one = initArray[x][1].to_s;
     two = initArray[x][2].to_s;
     three = initArray[x][3].to_s
     four = initArray[x][4].to_s;
     five = initArray[x][5].to_s;
#     data = data + '- ["' + theZero + '",' + one + ',"' + two + '","' + three + '",' + four + ',"' + five + '"]' +  "\n";
#     not writing the contain of each row UNLESS the value of three is Alive
     if three != "Dead" then;
         data = data + '- [' + theZero + ',' + one + ',"' + two + '","' + three + '",' + four + ',"' + five + '"]' +  "\n";
     end;     
     
    #   format of:     - ["Y", 0, "Z", "alive", 0, "mt"]
   end;
   File.open("activeInit.yml", 'w+') {|f| f.write(data) };
   event.respond "**Ready to Rumble.**  Initiative rolling and sorting is feckin complete. ";
   else; 
     event.respond "Who are you?";
   end;
end;          
##################################################################################################################
##################################################################################################################
bot.message(start_with: "!n") do |event|;
  event.message.delete; 
  activeInitiative = YAML.load(File.read("activeInit.yml"));
  names = YAML.load(File.read("nameBase.yml"));
  nameList = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  howMany = activeInitiative.length;
  if activeInitiative[0][2].to_s != "End of Round" then;
     if activeInitiative[0][2].length == 1 then;
        position = nameList.index(activeInitiative[0][2]);
        say = "**Entity " + names[position][0].to_s + " [" + activeInitiative[0][4].to_s  + "] has initiative.**";
      else;
        say = "**Entity " + activeInitiative[0][2].to_s + " [" + activeInitiative[0][4].to_s  + "] has initiative.**";
      end;        
  else;
           say = "**END of ROUND**";
  end;
  data = "---" + "\n";
      (1..(howMany-1)).each do |x|;
          theZero = activeInitiative[x][0].to_s;
          one = activeInitiative[x][1].to_s;
          two = activeInitiative[x][2].to_s;
          three = activeInitiative[x][3].to_s
          four = activeInitiative[x][4].to_s;
          five = activeInitiative[x][5].to_s;
             data = data + '- [' + theZero + ',' + one + ',"' + two + '","' + three + '",' + four + ',"' + five + '"]' +  "\n";
          #   format of:     - ["Y", 0, "Z", "alive", 0, "mt"]
      end;
  File.open("activeInit.yml", 'w+') {|f| f.write(data) }; 
  event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "!d") do |event|;
   event.message.delete; 
   activeInitiative = YAML.load(File.read("initiativeBase.yml"));
   howMany = (activeInitiative.length)-1;
   deaders = event.content.slice(2,99);
   data = "---" + "\n";
   (0..howMany).each do |x|;
       theZero = activeInitiative[x][0].to_s;
       one = activeInitiative[x][1].to_s;
       two = activeInitiative[x][2].to_s;
       three = activeInitiative[x][3].to_s
       four = activeInitiative[x][4].to_s;
       five = activeInitiative[x][5].to_s;
       if deaders.index(two) != nil then;
         three = "Dead";
       end;
       data = data + '- [' + theZero + ',' + one + ',"' + two + '","' + three + '",' + four + ',"' + five + '"]' +  "\n";
    #   format of:     - ["Y", 0, "Z", "alive", 0, "mt"]
   end;
   File.open("initiativeBase.yml", 'w+') {|f| f.write(data) };
   
   if (File.exist?("activeInit.yml")) then;
       activeInitiative = YAML.load(File.read("activeInit.yml"));
       howMany = (activeInitiative.length)-1;
       deaders = event.content.slice(2,99);
       data = "---" + "\n";
       (0..howMany).each do |x|;
           theZero = activeInitiative[x][0].to_s;
           one = activeInitiative[x][1].to_s;
           two = activeInitiative[x][2].to_s;
           three = activeInitiative[x][3].to_s
           four = activeInitiative[x][4].to_s;
           five = activeInitiative[x][5].to_s;
           if deaders.index(two) == nil then;
              data = data + '- [' + theZero + ',' + one + ',"' + two + '","' + three + '",' + four + ',"' + five + '"]' +  "\n";
  #      format of:     - ["Y", 0, "Z", "alive", 0, "mt"]
           end;
       end;
       File.open("activeInit.yml", 'w+') {|f| f.write(data) };
   end;
      
   event.respond "Dead complete for " + deaders;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "!a") do |event|;
   activeInitiative = YAML.load(File.read("initiativeBase.yml"));
   howMany = (activeInitiative.length)-1;
   livers = event.content.slice(2,99);
   data = "---" + "\n";
   (0..howMany).each do |x|;
       theZero = activeInitiative[x][0].to_s;
       one = activeInitiative[x][1].to_s;
       two = activeInitiative[x][2].to_s;
       three = activeInitiative[x][3].to_s
       four = activeInitiative[x][4].to_s;
       five = activeInitiative[x][5].to_s;
       if livers.index(two) != nil then;
         three = "Alive";
       end;
       data = data + '- [' + theZero + ',' + one + ',"' + two + '","' + three + '",' + four + ',"' + five + '"]' +  "\n";
    #   format of:     - ["Y", 0, "Z", "alive", 0, "mt"]
   end;
   File.open("initiativeBase.yml", 'w+') {|f| f.write(data) };
   event.respond "Live complete for " + livers;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "!s") do |event|;
  event.message.delete; 
   activeInitiative = YAML.load(File.read("initiativeBase.yml"));
   howMany = (activeInitiative.length)-1;
   say = "";
   (0..howMany).each do |x|;
     say = say + activeInitiative[x].inspect + "\n";
   end;
   event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "!x") do |event|;
  activeInitiative = YAML.load(File.read("initiativeBase.yml"));
  howMany = (activeInitiative.length)-1;
  bundle = event.content.slice(2,99); lenB = bundle.length
  dexMod = (bundle.slice(0,1));
  # account for a negative value in the dexterity modifier
  if dexMod == "-" then;
     dexMod = (bundle.slice(0,2));
     entity = bundle.slice(2,lenB-1)
  else; 
     entity = bundle.slice(1,lenB-1)
  end;

 
   data = "---" + "\n";
   (0..howMany).each do |x|;
       theZero = activeInitiative[x][0].to_s;
       one = activeInitiative[x][1].to_s;
       two = activeInitiative[x][2].to_s;
       three = activeInitiative[x][3].to_s
       four = activeInitiative[x][4].to_s;
       five = activeInitiative[x][5].to_s;
       if entity.index(two) != nil then;
         one = dexMod.to_s;   #make the value a string
       end;
       data = data + '- [' + theZero + ',' + one + ',"' + two + '","' + three + '",' + four + ',"' + five + '"]' +  "\n";
    #   format of:     - ["Y", 0, "Z", "alive", 0, "mt"]
   end;
   File.open("initiativeBase.yml", 'w+') {|f| f.write(data) };
   event.respond "Dex Mod complete for " + entity;
end;
#####################################################################
bot.run