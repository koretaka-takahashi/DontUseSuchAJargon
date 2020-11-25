class LikesController < ApplicationController
  before_action :authenticate_user! # ログイン済みかどうか。
  before_action :set_description
  before_action :set_term
  before_action :user_check, only: [:destroy] # いいね！した本人のみに削除権限

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
  
  # いいね！した本人かどうか
  def user_check
    if @like.user != current_user
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end
