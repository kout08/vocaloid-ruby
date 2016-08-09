lyric_filename = "lyric.txt"
midi_filename = "sample.mid"

lyric = File.open(lyric_filename).read.split(" ")
midi_txt = `ruby midi2text.rb #{midi_filename}`

puts midi_txt

print "\nselect track number :"

tr_num = gets.to_i

track_data = midi_txt.split("read")
track_notes = track_data[tr_num].gsub(/\n/," ").split(":")

tempo = track_data[1].split("\n")
tempo.delete_if{|item| item !~ /tempo/}
tempo = tempo[0].to_s.slice(/\(\w*.\w*/).sub(/\(/,"").to_f

track_notes.delete_if{|item| item !~ /note/}
track_notes.delete_if{|item| item =~ /off/ && item.end_with?(" 0")}
track_notes.delete_if{|item| item =~ /vel 0/}

notes = Array.new(track_notes.size){[]}

(1..track_notes.size).each do |n|
  notes[n-1] = track_notes[n-1].split(" ").delete_if{|item| item =~ /[a-z]/}.map{|item| item.to_i}
  notes[n-1].shift
end

puts "\ntrack data : #{notes}\n"
puts "tempo : #{tempo} bpm\n"
puts "lyric : #{lyric}\n"

# track data = [[note, velocity, length]]
# length to sec : sec = ( tempo * length ) / ( 60 * 480 )
