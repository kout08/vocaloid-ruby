require "ruby-sox"
require_relative 'translate-voice.rb'

word = gets.chomp
voice_file=Translater.voice(word)
a=gets.to_s
sox=Sox::Cmd.new()
sox.add_input(voice_file)
sox.set_output("sample_voice/test.wav")
sox.set_effects(:pitch => a)
sox.run
