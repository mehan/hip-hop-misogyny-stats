module Api  
  class RappersController < Api::BaseController

  def index
    @all_rappers = Rapper.where(song_count: 20)
  end

  # def show
  #   @rapper = Rapper.find(params[:id])
  # end

    private

      def rapper_params
      params.require(:rapper).permit(:name, :id)
      end

      def query_params
        # this assumes that an album belongs to an artist and has an :artist_id
        # allowing us to filter by this
        params.permit(:name, :id)
      end



  end
end 