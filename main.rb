# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require_relative 'lib/vocaloid.rb'
require_relative 'lib/adapt-voice.rb'
require_relative 'lib/translate-voice.rb'

set :bind, '0.0.0.0'

get '/' do
	erb :top
end

get '/top' do
	@title = 'Vocaloid Player'
	erb :top
end

get '/simple_make_voice' do
	@title = 'Vocaloid Player'
	erb :simple_make_voice
end

get '/detailed_make_voice' do
	erb :detailed_make_voice
end

get '/detailed_edit_voice' do
	erb :detailed_edit_voice
end

get '/expert_make_voice' do
	erb :not_implement
end

post '/generate_simple_voice' do
	@words = params[:words].gsub(/(\s)/, "")
	#@word_files = Translater.voice(@words)
	#WavController.adapt_voice(@word_files, (File.dirname(__FILE__) + "/public/output.wav"))
	WavController.adapt_voice(Translater.voice(@words), (File.dirname(__FILE__) + "/public/output.wav"))
	erb :finish_generate
end

post '/edit_detailed_voice' do
	@tempo = params[:tempo].to_i
	@words = params[:words].gsub(/(\s)/, "").split("")
	erb :detailed_edit_voice
end

post '/generate_detailed_voice' do
	@words = params[:words]
	@notes= params[:duration_val].values.map{|num| num.to_f}
	@octaves = params[:octaves_val].values.map{|num| num.to_i}
	@accidentals = params[:accidentals_val].values.map{|num| num.to_i}
	@scales = params[:pitch_val].values.map{|num| num.to_i}
	@scales.each_with_index do |scale, idx|
	@scales[idx] = @scales[idx] + @octaves[idx]*1200 + @accidentals[idx]*100
	end
	Vocaloid.generate_detailed_voice(Translater.voice(@words), @notes, @scales)
	erb :finish_generate
	#erb :test_detailed_generate
end

get '/player' do
	erb :player
end

get '/download_voice' do
	erb :download_voice_file
end

# Prevent to cache the old wav file
#after do
	#cache_control :no_store
#end
