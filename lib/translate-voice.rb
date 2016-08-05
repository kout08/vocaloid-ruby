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
		が: 'ga_1.wav',
		ぎ: 'gi_1.wav',
		ぐ: 'gu_1.wav',
		げ: 'ge_1.wav',
		ご: 'go_1.wav',
		ざ: 'za_1.wav',
		じ: 'zi_1.wav',
		ず: 'zu_1.wav',
		ぜ: 'ze_1.wav',
		ぞ: 'zo_1.wav',
		だ: 'da_1.wav',
		ぢ: 'di_1.wav',
		づ: 'du_1.wav',
		で: 'de_1.wav',
		ど: 'do_1.wav',
		ば: 'ba_1.wav',
		び: 'bi_1.wav',
		ぶ: 'bu_1.wav',
		べ: 'be_1.wav',
		ぼ: 'bo_1.wav',
		ぱ: 'pa_1.wav',
		ぴ: 'pi_1.wav',
		ぷ: 'pu_1.wav',
		ぺ: 'pe_1.wav',
		ぽ: 'po_1.wav',
		ん: "N_1.wav"
	}

	@translate_voice2 = {
		あ: "a.wav",
		い: "i.wav",
		う: "u.wav",
		え: "e.wav",
		お: "o.wav",
		か: "ka.wav",
		き: "ki.wav",
		く: "ku.wav",
		け: "ke.wav",
		こ: "ko.wav",
		さ: "sa.wav",
		し: "si.wav",
		す: "su.wav",
		せ: "se.wav",
		そ: "so.wav",
		た: "ta.wav",
		ち: "ti.wav",
		つ: "tu.wav",
		て: "te.wav",
		と: "to.wav",
		な: "na.wav",
		に: "ni.wav",
		ぬ: "nu.wav",
		ね: "ne.wav",
		の: "no.wav",
		は: "ha.wav",
		ひ: "hi.wav",
		ふ: "hu.wav",
		へ: "he.wav",
		ほ: "ho.wav",
		ま: "ma.wav",
		み: "mi.wav",
		む: "mu.wav",
		め: "me.wav",
		も: "mo.wav",
		や: "ya.wav",
		ゆ: "yu.wav",
		よ: "yo.wav",
		ら: "ra.wav",
		り: "ri.wav",
		る: "ru.wav",
		れ: "re.wav",
		ろ: "ro.wav",
		わ: "wa.wav",
		が: 'ga.wav',
		ぎ: 'gi.wav',
		ぐ: 'gu.wav',
		げ: 'ge.wav',
		ご: 'go.wav',
		ざ: 'za.wav',
		じ: 'zi.wav',
		ず: 'zu.wav',
		ぜ: 'ze.wav',
		ぞ: 'zo.wav',
		だ: 'da.wav',
		ぢ: 'di.wav',
		づ: 'du.wav',
		で: 'de.wav',
		ど: 'do.wav',
		ば: 'ba.wav',
		び: 'bi.wav',
		ぶ: 'bu.wav',
		べ: 'be.wav',
		ぼ: 'bo.wav',
		ぱ: 'pa.wav',
		ぴ: 'pi.wav',
		ぷ: 'pu.wav',
		ぺ: 'pe.wav',
		ぽ: 'po.wav',
		ん: "nn.wav",
		・: "no_voice.wav"
		p: "piano.wav"
	}

	@dir_name = File.dirname(__FILE__)

	def voice words
		voice_files = ["sample_voice", "sample_voice2"]
		translaters = [@translate_voice, @translate_voice2]
		speaker_kind = 1
		voice_file = voice_files[speaker_kind]
		translater = translaters[speaker_kind]
		case words
		when String
			if words.size > 1
				words.split("").map{ |char| @dir_name + "/#{voice_file}/#{translater[char.to_sym] }"}
			elsif words.size == 1
				"#{@dir_name}/#{voice_file}/#{translater[words.to_sym] }"
			else
				puts "An unexpected error has occured at function of Translater.voice"
				exit -1
			end
		when Array
			words.map{ |char| @dir_name + "/#{voice_file}/#{translater[char.to_sym]}" }
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
	puts Translater.voice("あいん".split(""))
	puts
	puts 'Test5'
	puts Translater.voice("あがうえ".split(""))
	puts
	puts 'Test last'
	puts Translater.voice("")
	puts
	puts 'Tests finished'
	puts
end

#test

