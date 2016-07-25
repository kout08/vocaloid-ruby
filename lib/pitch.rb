require "ruby-sox"
require_relative 'translate-voice.rb'

def pitch(word,oct) 
  sox=Sox::Cmd.new()
  sox.add_input(Translater.voice(word))
  sox.set_output("sample_voice/#{word}_#{oct}.wav")
  sox.set_effects(:pitch => oct)
  sox.run
end

word=gets.chomp
oct=gets.chomp

pitch(word,oct)
