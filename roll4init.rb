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

bot.run