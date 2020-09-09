class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @terms = @genre.terms.all.order(created_at: :desc)
  end  
end

private

# いらなくね？
# def genre_params
#   params.require(:genre).permit(:name)
# end
