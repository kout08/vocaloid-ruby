# encoding: utf-8
module Translater
	@translate_voice = {
		あ: "a_1.wav",
		い: "i_1.wav",
		う: "u_1.wav",
		え: "e_1.wav",
		お: "o_1.wav",
		か: "ka_1.wav",
		き: "ki_1.wav",
		く: "ku_1.wav",
		け: "ke_1.wav",
		こ: "ko_1.wav",
		さ: "sa_1.wav",
		し: "si_1.wav",
		す: "su_1.wav",
		せ: "se_1.wav",
		そ: "so_1.wav",
		た: "ta_1.wav",
		ち: "ti_1.wav",
		つ: "tu_1.wav",
		て: "te_1.wav",
		と: "to_1.wav",
		な: "na_1.wav",
		に: "ni_1.wav",
		ぬ: "nu_1.wav",
		ね: "ne_1.wav",
		の: "no_1.wav",
		は: "ha_1.wav",
		ひ: "hi_1.wav",
		ふ: "hu_1.wav",
		へ: "he_1.wav",
		ほ: "ho_1.wav",
		ま: "ma_1.wav",
		み: "mi_1.wav",
		む: "mu_1.wav",
		め: "me_1.wav",
		も: "mo_1.wav",
		や: "ya_1.wav",
		ゆ: "yu_1.wav",
		よ: "yo_1.wav",
		ら: "ra_1.wav",
		り: "ri_1.wav",
		る: "ru_1.wav",
		れ: "re_1.wav",
		ろ: "ro_1.wav",
		わ: "wa_1.wav",
		ん: "N_1.wav"
	}

	@dir_name = File.dirname(__FILE__)

	def voice words
		case words
		when String
			if words.size > 1
				words.split("").map{ |char| @dir_name + "/sample_voice/#{@translate_voice[char.to_sym] }"}
			elsif words.size == 1
				"#{@dir_name}/sample_voice/#{@translate_voice[words.to_sym] }"
			else
				puts "An unexpected error has occured at function of Translater.voice"
				exit -1
			end
		when Array
			words.map{ |char| @dir_name + "/sample_voice/#{@translate_voice[char.to_sym]}" }
		else
			puts 'Words class must be string or array'
		end
	end

	module_function :voice
end

#Test code
def test
	include Translater
	puts 'Test1'
	puts Translater.voice("あ")
	puts
	puts 'Test2'
	puts Translater.voice("あいうえ")
	puts
	puts 'Test3'
	puts Translater.voice("あいうえ".split(""))
	puts
	puts 'Test4'
	puts Translater.voice("")
end

#test

