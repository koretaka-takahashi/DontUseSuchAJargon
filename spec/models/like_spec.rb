require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @user = FactoryBot.create(:user1)
    @term = FactoryBot.create(:term1)
    @description = FactoryBot.create(:description1, user_id: @user.id, term_id: @term.id)
  end
  it "is valid if user and description are present" do
    like = Like.new(user_id: @user.id, description_id: @description.id)
    expect(like).to be_valid
  end
  it "is invalid if there is no user" do
    like = Like.new(user_id: nil, description_id: @description.id)
    like.valid?
    expect(like.errors[:user]).to include("を入力してください")
  end
  it "is invalid if there is no description" do
    like = Like.new(user_id: @user.id, description_id: nil)
    like.valid?
    expect(like.errors[:description]).to include("を入力してください")
  end
  it "is invalid if the combination of user and description is duplicated" do
    like = Like.create(user_id: @user.id, description_id: @description.id)
    like2 = Like.new(user_id: @user.id, description_id: @description.id)
    like2.valid?
    expect(like2.errors[:description_id]).to include("はすでに存在します")
  end
end
