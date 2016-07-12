# encoding: utf-8
require_relative 'adapt-voice.rb'
require_relative 'translate-voice.rb'

word = gets.chomp
WavController.adapt_voice(Translater.voice(word), (File.dirname(__FILE__) + "/../public/output.wav"))
#WavController.adapt_voice(Translater.voice("こんにちは"), "output.wav")
#WavController.adapt_voice(Translater.voice("こんにちは"), "../public/output.wav")
