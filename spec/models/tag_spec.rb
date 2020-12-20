require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @user = FactoryBot.create(:user1)
    @genre = FactoryBot.create(:genre1)
  end
  it "is invalid if the name is blank" do
    tag = FactoryBot.build(:tag1, name: "", user_id: @user.id, genre_id: @genre.id)
    tag.valid?
    expect(tag.errors[:name]).to include("を入力してください")
  end
  it "is invalid if the name is greater than 20 characters" do
    tag = FactoryBot.build(:tag1, name: "a" * 21, user_id: @user.id, genre_id: @genre.id)
    tag.valid?
    expect(tag.errors[:name]).to include("は20文字以内で入力してください")
  end
  it "is valid if the name is present and within 20 characters" do
    tag = FactoryBot.build(:tag1, name: "a" * 20, user_id: @user.id, genre_id: @genre.id)
    expect(tag).to be_valid
  end
end
