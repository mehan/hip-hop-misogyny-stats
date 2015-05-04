class RappersController < ApplicationController

  def new
    @rapper_name = params[:rapper_name]
  end

  def show
    @all_rappers = Rappers.all
  end




def lookup_rapper(rapper_name)


  # Rapper.find_by(name: 'rapper_name')

song_index = RapGenius.search_by_artist("#{rapper_name}")

if song_index == []
  puts "Sorry, the rapper you searched for was not found."

else

  song_ids = song_index.map do |song| 
    song.id 
  end

  songs = song_ids.map do |song_id|
  RapGenius::Song.find(song_id)
  end

  all_lyrics = songs.map do |song_id|
  song_id.document['response']['song']['lyrics']['plain']
  end

  lyrics_string = all_lyrics.join(",")

  lyrics_array = lyrics_string.split(/\W+/)

  pussy_count = 0
  bitch_count = 0
  ho_count = 0
  song_count = song_ids.length

  lyrics_array.each do |lyric|
    if lyric.include? "pussy"
      pussy_count += 1
    elsif lyric.include? "bitch"
      bitch_count += 1
    elsif lyric == "ho" || lyric == "hoes"
      ho_count += 1
    end
    end

  rapper = Rapper.new(rapper_name, pussy_count, bitch_count, ho_count, song_count)

  # Rapper.create(name: "" pussy_count: "" bitch_count: "" ho_count: "" overall_score: "" song_count: "")

  
  print_rapper(rapper)

end
end




end