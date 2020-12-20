require 'rails_helper'

RSpec.describe Tagging, type: :model do
  before do
    @user = FactoryBot.create(:user1)
    @genre = FactoryBot.create(:genre1)
    @term = FactoryBot.create(:term1)
    @tag = Tag.create(name: "tag1", user_id: @user.id, genre_id: @genre.id)
  end
  it "is invalid if there is no tag" do
    tagging = Tagging.new(tag_id: nil, term_id: @term.id)
    tagging.valid?
    expect(tagging.errors[:tag]).to include("を入力してください")
  end
  it "is invalid if there is no term" do
    tagging = Tagging.new(tag_id: @tag.id, term_id: nil)
    tagging.valid?
    expect(tagging.errors[:term]).to include("を入力してください")
  end
  it "is valid if tag and term are present" do
    tagging = Tagging.new(tag_id: @tag.id, term_id: @term.id)
    expect(tagging).to be_valid
  end
end
