class DescriptionsController < ApplicationController
  before_action :set_term, only: [:show, :edit, :update, :destroy]
  # before_action :set_genres, only: [:new, :edit]
  # before_action :authenticate_user!, except: [:index, :show]
  # before_action :user_check, only: [:edit, :update, :destroy]

  def show
  end

  def new
    @description = Description.new
  end

  def create
    @description = current_user.descriptions.build(description_params)
    @description.term_id = params[:term_id]
    if @description.save
      redirect_to term_path(@description.term), notice: "解説を投稿しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @description.update(description_params)
      redirect_to term_path(@description.term), notice: "更新しました"
    else
      render :new
    end
  end

  def destroy
    @description.destroy
    redirect_to term_path(@description.term), notice: "解説を削除しました"
  end

  private

  def set_description
    @description = Description.find(params[:id])
  end

  def set_term
    @term = Term.all
  end

  def description_params
    params.require(:description).permit(:content, :user_id, :term_id)
  end

  def user_check
    if @description.user != current_user
      flash[:alert] = "権限がありません。"
      redirect_back(fallback_location: root_path)
    end  
  end
end

