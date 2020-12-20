require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid if the name is blank" do
    user = FactoryBot.build(:user1, name: "")
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  it "is invalid if the name is greater than 50 characters" do
    user = FactoryBot.build(:user1, name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end
  it "is invalid if the email is greater than 100 characters" do
    user = FactoryBot.build(:user1, email: "#{"a" * 101}@a.com")
    user.valid?
    expect(user.errors[:email]).to include("は100文字以内で入力してください")
  end
  it "is invalid if the email is illegal" do
    user = FactoryBot.build(:user1, email: "a.com")
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end
  it "is invalid if the email is blank" do
    user = FactoryBot.build(:user1, email: "")
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  it "is invalid if the password is less than 6 characters" do
    user = FactoryBot.build(:user1, password: "aaaaa", password_confirmation: "aaaaa")
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
  it "is invalid if the password and password_confirmation don't match" do
    user = FactoryBot.build(:user1, password: "user1user1", password_confirmation: "user1user1a")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
  end
  it "is invalid if the profile is greater than 1500 characters" do
    user = FactoryBot.build(:user1, profile: "a" * 1501)
    user.valid?
    expect(user.errors[:profile]).to include("は1500文字以内で入力してください")
  end
  it "is valid if the name email, and other items are correct" do
    user = FactoryBot.build(:user1, name: "user1", email: "user1@user1.com")
    expect(user).to be_valid
  end
end
