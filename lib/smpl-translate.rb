require_relative 'translate-voice.rb'

while (str = gets.chomp) != "0"
	p str
	p "#{Translater.voice str}"
end
