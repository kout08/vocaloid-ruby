# encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
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
	erb :not_implement
end

get '/expert_make_voice' do
	erb :not_implement
end

post '/generate_simple_voice' do
	@words = params[:words].gsub(/(\s)/, "")
	#@word_files = Translater.voice(@words)
	#WavController.adapt_voice(@word_files, (File.dirname(__FILE__) + "/public/output.wav"))
	'Hello'
	WavController.adapt_voice(Translater.voice(@words), (File.dirname(__FILE__) + "/public/output.wav"))
	erb :file_download
end

get '/player' do
	erb :player
end

get '/download_voice' do
	send_file(File.dirname(__FILE__) + '/public/output.wav')
	'Success Installed'
end
