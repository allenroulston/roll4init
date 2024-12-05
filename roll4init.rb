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
bot.message(start_with: "SHIT") do |event|;
   say = "Here Come da Judge: \n";

   conn = PG.connect(ENV['DATABASE_URL'])
#  PG.table_drop('hitPoints').run
   conn.exec("CREATE TABLE hitPoints (
        name varchar,
        full, integer,
        now, integer)")
        
=begin
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
=end
   wut = conn.inspect;
   conn.close

   event.respond result.inspect;      
end;
##################################################################################################################
##################################################################################################################

#####################################################################
bot.run