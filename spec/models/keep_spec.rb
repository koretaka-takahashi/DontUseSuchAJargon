require 'rails_helper'

RSpec.describe Keep, type: :model do
  before do
    @user = FactoryBot.create(:user1)
    @term = FactoryBot.create(:term1)
  end
  it "is valid if user and term are present" do
    keep = Keep.new(user_id: @user.id, term_id: @term.id)
    expect(keep).to be_valid
  end
  it "is invalid if there is no user" do
    keep = Keep.new(user_id: nil, term_id: @term.id)
    keep.valid?
    expect(keep.errors[:user]).to include("を入力してください")
  end
  it "is invalid if there is no term" do
    keep = Keep.new(user_id: @user.id, term_id: nil)
    keep.valid?
    expect(keep.errors[:term]).to include("を入力してください")
  end
  it "is invalid if the combination of user and term is duplicated" do
    keep = Keep.create(user_id: @user.id, term_id: @term.id)
    keep2 = Keep.new(user_id: @user.id, term_id: @term.id)
    keep2.valid?
    expect(keep2.errors[:term_id]).to include("はすでに存在します")
  end
end
