# encoding: utf-8 
require 'rubygems' 
require 'ruby-sox' 


module Vocaloid_duration
	def duration_voice (word_file, duration_time, tmp_file) 
		duration_out = Sox::Cmd.new 
		.add_input(word_file) 
		.set_output(tmp_file)
		.set_effects(:stretch => duration_time) 
		duration_out.run 
	end 

	module_function :duration_voice
end

=begin
#ファイル名を入力 
puts "input file name" 
word = gets.chomp 

#伸ばす長さを数字で入力 
puts "duration time" 
duration = gets.chomp 


duration_voice(word,duration.to_f)
end
=end
