require 'rubygems'
require 'wav-file'

module WavController
	# 0:Normal mode, 1:Debug mode
	@debug = 0
	def adapt_voice (voice_files, output_file)
		if voice_files.size < 1
			puts "Please set voice files at reast 1"
			return -1
		elsif voice_files.size == 1
			puts "Not support now"
			return -1
		else
			formats = voice_files.map{ |file_name|
				WavFile::readFormat open(file_name)
			}

			# Check sampling format
			if @debug == 1
				formats.each do |format|
					puts format
				end
			end

			format = formats.first
			dataChunk = WavFile::readDataChunk(open(voice_files.shift))

			voice_files.each do |f|
				data = WavFile::readDataChunk(open(f))
				dataChunk.data += data.data
			end

			if @debug == 1
				puts format
			end
		end

		open(output_file, "w") do |out|
			WavFile::write(out, format, [dataChunk])
		end
	end

	module_function :adapt_voice
end

WavController.adapt_voice(["./sample_voice/a_1.wav","./sample_voice/i_1.wav","./sample_voice/u_1.wav"], "output.wav")
#adapt_voice("./sample_voice/a_1.wav","./sample_voice/i_1.wav","./sample_voice/u_1.wav","output.wav")
#adapt_voice("./sample_voice/a_1.wav","./sample_voice/i_1.wav","output.wav")
