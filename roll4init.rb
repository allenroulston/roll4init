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
puts "          Roll 4 Init will be active soon"
puts;

initiativeBase = YAML.load(File.read("initiativeBase.yml"));

bot.message(start_with: "hello") do |event|;
   event.respond "I heard you";
end;


bot.run