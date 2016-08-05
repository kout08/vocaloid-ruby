DEBUG = 0
module Voice_data_manager
	@voice_data_dir = File.dirname(__FILE__) + '/../public'
	@voice_data_file = "#{@voice_data_dir}/voice_data.txt"
	class << self
		def save_voice_data voice_data_arr
			### voice_data_arr struct ###
			#[0] Mode : Fixnum
			#		0:simple_generate, 1:detailed_generate
			#[1] Tempo : Fixnum
			#[2] Words : Array
			#[3] Notes : Array
			#[4] Scales : Array
			#[5] Octaves : Array
			#[6] Accidentals : Array
			#######################
			File.open(@voice_data_file, 'w') do |file|
				voice_data_arr.each do |data|
					file.write data.to_s
					file.write "\n"
				end
			end
		end

		def open_voice_data
			unless File.exist?(@voice_data_file)
				generate_initial_voice_data	
			end
			puts "Open the file : #{@voice_data_file}"
			file_data = File.readlines(@voice_data_file)
			p file_data if DEBUG == 1
			p file_data if DEBUG == 3
			file_data.each_with_index do |data, idx|
				case idx
				when 0,1
					file_data[idx] = data.chomp.to_i
				when 2
					file_data[idx] = data.chomp.split(",")
				else
					file_data[idx] = data.chomp.split(",").map{|num| num.to_i}
				end
			end
			puts file_data if DEBUG == 1
			p file_data if DEBUG == 2
			p file_data[3] if DEBUG == 2
			puts file_data[3].class if DEBUG == 2
			return file_data
		end

		def generate_initial_voice_data
			sample_data = [0, 60, "さんぷる".split("").join(',')]
			save_voice_data sample_data
		end
	end
end

def test1
	data_arr_smpl = ["1", "120", "どれみはそらしど", "33333333", "01234567", "11111111", "00000000"]
	data_arr_smpl.each_with_index do |data, idx|
		case idx
		when 0,1
			data_arr_smpl[idx] = data_arr_smpl[idx].to_i
		when 2
			data_arr_smpl[idx] = data_arr_smpl[idx].split("").map{|i| i.to_s}.join(',')
		else
			data_arr_smpl[idx] = data_arr_smpl[idx].split("").map{|i| i.to_i}.join(',')
		end
	end
	Voice_data_manager.save_voice_data data_arr_smpl
	Voice_data_manager.open_voice_data
end

def test2
	Voice_data_manager.open_voice_data
end

def test3
	p Voice_data_manager.open_voice_data
end

test1 if DEBUG == 1
test2 if DEBUG == 2
test3 if DEBUG == 3
