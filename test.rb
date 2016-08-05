require_relative 'lib/voice_data_manager.rb'
voice_data = Voice_data_manager.open_voice_data
@tempo = voice_data[1]
@words = voice_data[2]
puts @words.class
p @words
puts @words
p voice_data[4]
puts voice_data[4][3].class
