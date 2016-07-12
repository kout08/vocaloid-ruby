require 'sinatra'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

get '/' do
	@title = 'Vocaloid Player'
	erb :top
end

get '/input_word' do
	@title = 'Vocaloid Player'
	@chars = ['a', 'b', 'c']
	erb :input_word
end

get '/simple_player' do
	@title = 'Vocaloid Player'
	erb :player
end
