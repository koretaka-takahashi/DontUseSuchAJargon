require 'rails_helper'

RSpec.feature Genre, type: :feature do
  scenario 'ジャンルを選択すると詳細ページでそのジャンルのTermが表示される' do
    genre = FactoryBot.create(:genre1)
    term1 = FactoryBot.create(:term1, name: "term1", genre_id: genre.id)
    term2 = FactoryBot.create(:term2, name: "term2", genre_id: genre.id)
    visit root_path
    click_on genre.name
    expect(page).to have_content "#{genre.name} 関連のTerm一覧"
    expect(page).to have_content term1.name
    expect(page).to have_content term2.name
  end
end
