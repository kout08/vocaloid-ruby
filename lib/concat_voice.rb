require 'ruby-sox'

module Vocaloid_concat
	def concat_voice words, output_dir
		sx = Sox::Combiner.new(words, :combine => :concatenate)
		sx.write(output_dir)
	end

	module_function :concat_voice
end

def test
	dir = './lib/sample_voice/'
	a = "#{dir}a_1.wav"
	i = "#{dir}i_1.wav"
	u = "#{dir}u_1.wav"
	op = 'public/output.wav'
end

#test
