require 'rails_helper'

RSpec.describe Description, type: :model do
  before do
    @user = FactoryBot.create(:user1)
    @term = FactoryBot.create(:term1)
  end
  it "is invalid if the content is blank" do
    description = FactoryBot.build(:description1, content: "", user_id: @user.id, term_id: @term.id)
    description.valid?
    expect(description.errors[:content]).to include("を入力してください")
  end
  it "is invalid if the content is greater than 1000 characters" do
    description = FactoryBot.build(:description1, content: "a" * 1001, user_id: @user.id, term_id: @term.id)
    description.valid?
    expect(description.errors[:content]).to include("は1000文字以内で入力してください")
  end
  it "is valid if the content is present and within 1000 characters" do
    description = FactoryBot.build(:description1, content: "a" * 1000, user_id: @user.id, term_id: @term.id)
    expect(description).to be_valid
  end
end
