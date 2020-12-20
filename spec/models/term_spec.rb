require 'rails_helper'

RSpec.describe Term, type: :model do
  it "is invalid if the name is blank" do
    term = FactoryBot.build(:term1, name: "")
    term.valid?
    expect(term.errors[:name]).to include("を入力してください")
  end
  it "is invalid if the name is greater than 50 characters" do
    term = FactoryBot.build(:term1, name: "a" * 51)
    term.valid?
    expect(term.errors[:name]).to include("は50文字以内で入力してください")
  end
  it "is valid if the name is present and within 50 characters" do
    term = FactoryBot.build(:term1, name: "a" * 50)
    expect(term).to be_valid
  end
end
