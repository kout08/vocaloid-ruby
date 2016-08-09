# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/vocaloid.rb'
require_relative 'lib/adapt-voice.rb'
require_relative 'lib/translate-voice.rb'
require_relative 'lib/voice_data_manager.rb'

set :bind, '0.0.0.0'

get '/' do
	erb :top
end

get '/top' do
	@title = 'Vocaloid Player'
	erb :top
end

get '/simple_make_voice' do
	@tempo = 60
	@words = "あいうえお"
	@title = 'Vocaloid Player'
	erb :simple_make_voice
end

get '/detailed_make_voice' do
	@tempo = 60
	@words = "どれみはそらしど"
	@title = 'Vocaloid Player'
	erb :detailed_make_voice
end

get '/detailed_edit_voice' do
	erb :detailed_edit_voice
end

get '/edit_current_voice' do
	voice_data = Voice_data_manager.open_voice_data
	@tempo = voice_data[1].to_i
	@words = voice_data[2]
	case voice_data[0].to_i
	when 0
		@words = @words.join
		erb :simple_make_voice
	when 1
		@default_notes = voice_data[3]
		@default_scales = voice_data[4]
		@default_octaves = voice_data[5]
		@default_accidentals = voice_data[6]
		erb :detailed_edit_voice
	end
end

get '/expert_make_voice' do
	erb :not_implement
end

post '/generate_simple_voice' do
	@tempo = params[:tempo].to_i
	@words = params[:words].gsub(/(\s)/, "")
	#@word_files = Translater.voice(@words)
	#WavController.adapt_voice(@word_files, (File.dirname(__FILE__) + "/public/output.wav"))
	WavController.adapt_voice(Translater.voice(@words), (File.dirname(__FILE__) + "/public/output.wav"))
	Voice_data_manager.save_voice_data([0, @tempo, @words.split("").join(',')])
	erb :finish_generate
end

post '/edit_detailed_voice' do
	@tempo = params[:tempo].to_i
	@words = params[:words].gsub(/(\s)/, "").split("")
	words_size = @words.size
	@default_notes = Array.new(words_size, 2)
	@default_scales = Array.new(words_size, 0)
	@default_octaves = Array.new(words_size, 1)
	@default_accidentals = Array.new(words_size, 0)
	erb :detailed_edit_voice
end

post '/generate_detailed_voice' do
	@notes_arr = [0.25, 0.5, 1.0, 2.0, 4.0]
	@scales_arr = [0, 200, 400, 500, 700, 900, 1100, 1200]
	@octaves_arr = [-1, 0, 1, 2]
	@accidentals_arr = [0, 100, -100]
	@raw_notes_pos = Array.new
	@raw_scales_pos = Array.new
	@raw_octaves_pos = Array.new
	@raw_accidentals_pos = Array.new
	@tempo = params[:tempo].to_i
	@words = params[:words]
	@notes= params[:duration_val].values.map{|num| num.to_f}
	@octaves = params[:octaves_val].values.map{|num| num.to_i}
	@accidentals = params[:accidentals_val].values.map{|num| num.to_i}
	@scales = params[:pitch_val].values.map{|num| num.to_i}
	@words.size.times do |idx|
		@raw_notes_pos << @notes_arr.find_index(@notes[idx])
		@raw_scales_pos<< @scales_arr.find_index(@scales[idx])
		@raw_octaves_pos << @octaves_arr.find_index(@octaves[idx])
		@raw_accidentals_pos << @accidentals_arr.find_index(@accidentals[idx])
		@scales[idx] = @scales[idx] + @octaves[idx]*1200 + @accidentals[idx]
		@notes[idx] = @notes[idx]*60/@tempo
	end
	Vocaloid.generate_detailed_voice(Translater.voice(@words), @notes, @scales)
	Voice_data_manager.save_voice_data([1, @tempo, @words.join(','), @raw_notes_pos.join(','), @raw_scales_pos.join(','), @raw_octaves_pos.join(','), @raw_accidentals_pos.join(',')])
	erb :finish_generate
	#erb :test_detailed_generate
end

get '/player' do
	erb :player
	#erb :js_wav_player
end

get '/js_player' do
	erb :js_wav_player
end

get '/download_voice' do
	erb :download_voice_file
end

# Prevent to cache the old wav file
#after do
	#cache_control :no_store
#end
