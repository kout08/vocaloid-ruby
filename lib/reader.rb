lyric = File.open('lyric.txt').read.split(" ")
midi_txt = `ruby midi2text.rb`
track_data = midi_txt.split("read track")

puts track_data
