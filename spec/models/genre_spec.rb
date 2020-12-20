require 'rails_helper'

RSpec.describe Genre, type: :model do
  it "is invalid if the name is blank" do
    genre = FactoryBot.build(:genre1, name: "")
    genre.valid?
    expect(genre.errors[:name]).to include("を入力してください")
  end
  it "is invalid if the name is greater than 50 characters" do
    genre = FactoryBot.build(:genre1, name: "a" * 51)
    genre.valid?
    expect(genre.errors[:name]).to include("は50文字以内で入力してください")
  end
  it "is valid if the name is present and within 50 characters" do
    genre = FactoryBot.build(:genre1, name: "a" * 50)
    expect(genre).to be_valid
  end
end
