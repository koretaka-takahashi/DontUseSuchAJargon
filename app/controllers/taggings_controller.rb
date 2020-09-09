class TaggingsController < ApplicationController
  before_action :set_term, only: [:new, :create] 
  before_action :set_tags, only: [:new, :create] # タグ付け時に選ぶリスト用に取得しておく（いらねーか？！）

  
  def new
    # binding.pry
    @tagging = Tagging.new
  end

  def create
    # binding.pry

    # @term = Term.find(params[:term_id])

    @tagging = @term.taggings.build(tagging_params)
    if @tagging.save
      redirect_to term_path(@term), notice: "タグ付けしました。"
    else
      render :new
    end

  end

  def destroy
    tagging = @term.tags.find(params[:id])
  end

  private

  def set_term
    @term = Term.find(params[:term_id])
  end   

  def set_tags
    @tags = Tag.where(genre_id: @term.genre_id).all.order(:name)
  end  

  def tagging_params
    params.require(:tagging).permit(:term_id, :tag_id)
  end   
end
