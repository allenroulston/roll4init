#
require 'discordrb';
require 'yaml';
require 'date';
require 'securerandom';
include Math;


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

bot.message(start_with:"gmhelp") do |event|;
  say = "Command List \n"
  say = say + "!r : roll new initiatives \n";
  say = say + "!n : show next initiative \n";
  say = say + "!d@ : mark Entity Dead \n";
  say = say + "   where @ = A or B or C... \n";
  say = say + "!a@ : mark Entity Alive \n";
  say = say + "   where @ = A or B or C... \n";
  say = say + "!x@ : revise Dex Mod for @ \n";
  say = say + "   where @ = A or B or C... \n";
   event.respond say;
end;
##################################################################################################################
##################################################################################################################
bot.message(start_with: "rollai") do |event|;
  event.message.delete; 
  if event.user.nick != nil;  theUser = event.user.nick;  else;  theUser = event.user.name;  end;
  if theUser == "Mr. DM" then;
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
   event.respond "**Ready to Rumble.**  Initiative rolling and sorting is complete. ";
   else; 
     event.respond "Who are you?";
   end;
end;          


bot.run