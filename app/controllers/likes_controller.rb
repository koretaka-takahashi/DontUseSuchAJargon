class LikesController < ApplicationController
  before_action :authenticate_user! # ログイン済みかどうか。
  before_action :set_description
  before_action :set_term

  def create
    @like = current_user.likes.build(description_id: @description.id)
    @like.save
    # @like.description_id = @description.id
  end

  def destroy
    like = current_user.likes.find_by(description_id: @description.id)
    like.destroy
  end

  private

  def set_term
    @term = Term.find(params[:term_id])
  end

  def set_description
    @description = Description.find(params[:description_id])
  end   
end
