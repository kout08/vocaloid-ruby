# encoding: utf-8
require 'tempfile'
require_relative 'adapt-voice.rb'
require_relative 'translate-voice.rb'
require_relative 'pitch.rb'
require_relative 'duration.rb'
require_relative 'concat_voice.rb'

module Vocaloid
	class << self
		def generate_simple_voice (words_arr)
			concat_voice(words_arr)
		end

		def generate_detailed_voice (words, durations, pitches)
			@new_words = Array.new
			@tempfiles = Array.new
			@tempfiles2 = Array.new

			if(words.size < 2)
				puts 'Words size is small'
			end

			if(words.size != durations.size || durations.size != pitches.size)
				puts 'Some data size is wrong'
				exit 1
			end

			words.size.times do |idx|
				@tempfiles << Tempfile.new(['vocaloid_output_tempfile', '.wav'])
				@tempfiles2 << Tempfile.new(['vocaloid_output_tempfile', '.wav'])
				p 'Now changing' + @tempfiles[idx].path + "\n"
				@new_words[idx] = change_word_duration(words[idx], durations[idx], @tempfiles[idx].path)
				@new_words[idx] = change_word_pitch(@tempfiles[idx].path, pitches[idx], @tempfiles2[idx].path)
			end

			#output_dir = File.dirname(__FILE__) + "/../public/output.wav"
			concat_voice(@new_words)
			@tempfiles.each do |tf|
				tf.close!
			end
			@tempfiles2.each do |tf|
				tf.close!
			end
		end

		def change_word_duration(word, duration, tmp)
			Vocaloid_duration.duration_voice(word, duration, tmp)
			puts "Change #{word}'s duration to #{duration}"
			return tmp
		end

		def change_word_pitch(word, pitch, tmp)
			Vocaloid_pitch.pitch(word, pitch, tmp)
			puts "Change #{word}'s pitch to #{pitch}"
			return tmp
		end

		def concat_voice(words)
			puts
			p words
			puts
			output_dir = File.dirname(__FILE__) + "/../public/output.wav"
			puts "Generate output file to '#{output_dir}'"
			Vocaloid_concat.concat_voice(words, output_dir)
			#WavController.adapt_voice(@new_words, output_dir)
		end

		def test2
			puts 'test2'
			return 'test2'
		end
	end
	#module_function :generate_detailed_voice
end

=begin
#input_words = gets.chomp
input_words = 'かきく'
words = Translater.voice(input_words)
puts words.size
p words
durations = [3,2,3]
pitches = [3,2,3]
pitches2 = [300,200,300]
v = Vocaloid.new
v.generate_detailed_voice(words, durations, pitches2)
#v.concat_voice words
=end

#Vocaloid.generate_detailed_voice(Translater.voice('あいう'), [1, 2, 3], [100, 200, 300])

def test
	#Vocaloid.generate_detailed_voice(Translater.voice('あいう'), [1, 2, 3], [100, 200, 300])
	Vocaloid.generate_detailed_voice(Translater.voice('あいう'), [4, 2, 3], [200, 400, 600])
end

#test
