class RappersController < ApplicationController

  def new
    @rapper = Rapper.new
end

  def index
    @all_rappers = Rappers.all
  end

  def show
  end

def create
 @rapper = Rapper.new(rapper_params)

# if params['rapper'] == ""
# # if rapper_params == ""
#   render :new, alert: "Sorry, the rapper you searched for was not found."


if Rapper.exists?(name: @rapper.name)
      redirect_to rapper_path
    else

@song_index = RapGenius.search_by_artist(@rapper.name)

if @song_index == []
  render :new, alert: "Sorry, the rapper you searched for was not found."
else
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

binding.pry

# @new_rapper = Rapper.new(name:"#{@name}" pussy_count:"#{@pussy_count}" bitch_count:"#{@bitch_count}" ho_count:"#{@ho_count}" overall_score:"#{@overall_score}" song_count:"#{@song_count}")

# @new_rapper = Rapper.new(name:@name pussy_count:@pussy_count bitch_count:@bitch_count ho_count:@ho_count overall_score:@overall_score song_count:@song_count)

#     if @new_rapper.save
#     redirect_to rapper_path
#   else
#     render :new, alert: "Sorry, we encountered an error while trying to look up that rapper. Please try again."
  
# end

end
end
end

private

def rapper_params
  params.require(:rapper).permit(:name)
end

end