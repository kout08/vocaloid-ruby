def read(midi_filename, lyric_filename, tr_num)
  
  lyric = File.open(lyric_filename).read.split(" ")
  midi_txt = `ruby midi2text.rb #{midi_filename}`
  
  tr_num.to_i
  
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
    notes[n-1] = track_notes[n-1].gsub(/on/,"1").gsub(/off/,"0").split(" ").delete_if{|item| item =~ /[a-z]/}.map{|item| item.to_i}
    notes[n-1].delete_at(1)
  end
  
  return notes, tempo, lyric
  
end

p read("sample.mid", "lyric.txt", 3)

# track data = [[on/off, note, velocity, length]] on:1 off:0
# length to sec : sec = ( tempo * length ) / ( 60 * 480 )
