class RappersController < ApplicationController

# Genius.access_token = ENV["GENIUS_ACCESS_TOKEN"]
RapGenius::Client.access_token = ENV["GENIUS_ACCESS_TOKEN"]

def about
  @rappers = Rapper.all
  end

  def new
    @rapper = Rapper.new
end

  def index
    @all_rappers = Rapper.where(song_count: 20)
  end

  def show
    @rapper = Rapper.find(params[:id])
  end

def create

flash[:alert] = nil  
@rapper = Rapper.new(rapper_params)
@song_index = RapGenius.search_by_artist(@rapper.name)


if @song_index == []
  flash[:alert] = "Sorry, the rapper you searched for was not found."
  render :new 


elsif Rapper.exists?(name: @song_index[0].artist.name)
      @artist_name = @song_index[0].artist.name
      @new_rapper = Rapper.find_by(name: @artist_name)
      redirect_to @new_rapper

    else
  @artist_name = @song_index[0].artist.name
  @song_ids = @song_index.map do |song| 
    song.id 
  end

  @songs = @song_ids.map do |song_id|
  RapGenius::Song.find(song_id)
  end

  @all_lyrics = @songs.map do |song_id|
  song_id.document['response']['song']['lyrics']['plain']
  end

  @lyrics_string = @all_lyrics.join(",")
  @lyrics_array = @lyrics_string.split(/\W+/)

  @pussy_count = 0
  @bitch_count = 0
  @ho_count = 0
  @song_count = @song_ids.length

  @lyrics_array.each do |lyric|
    if lyric.include? "pussy"
      @pussy_count += 1
    elsif lyric.include? "bitch"
      @bitch_count += 1
    elsif lyric == "ho" || lyric == "hoes"
      @ho_count += 1
    end
    end

@overall_score = @pussy_count + @bitch_count + @ho_count  

@new_rapper = Rapper.new(name:@artist_name, pussy_count:@pussy_count, bitch_count:@bitch_count, ho_count:@ho_count, overall_score:@overall_score, song_count:@song_count)

    if @new_rapper.save
    redirect_to @new_rapper
  else
      flash[:alert] = "Sorry, we encountered an error while trying to look up that artist. Please try again."
  render :new 
end
end
end

private

def rapper_params
  params.require(:rapper).permit(:name, :id)
end

end