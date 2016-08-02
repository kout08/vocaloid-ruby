require "ruby-sox"
require_relative 'translate-voice.rb'

module Vocaloid_pitch
	def pitch(word_file, oct, tmp_file) 
		sox=Sox::Cmd.new()
		sox.add_input(word_file)
		sox.set_output(tmp_file)
		sox.set_effects(:pitch => oct)
		sox.run
	end

	module_function :pitch
end

=begin
word=gets.chomp
oct=gets.chomp

pitch(word,oct)
=end
