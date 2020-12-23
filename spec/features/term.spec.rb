require 'rails_helper'

RSpec.feature Term, type: :feature do
  scenario 'ジャンル詳細ページでTermを選択すると詳細ページに遷移しそのTermの解説一覧が表示される' do
    genre = FactoryBot.create(:genre1)
    user = FactoryBot.create(:user1)
    term = FactoryBot.create(:term1, genre_id: genre.id)
    description1 = FactoryBot.create(:description1, content: "description1", term_id: term.id, user_id: user.id)
    description2 = FactoryBot.create(:description2, content: "description2", term_id: term.id, user_id: user.id)
    visit genre_path(genre.id)
    click_on term.name
    expect(page).to have_content description1.content
    expect(page).to have_content description2.content
  end
  scenario 'Term名で検索できる' do
    term1 = FactoryBot.create(:term1)
    term2 = FactoryBot.create(:term2)
    visit root_path
    fill_in 'q[name_cont]', with: term1.name, match: :first
    click_on '検索', match: :first
    expect(current_path).to eq terms_path
    expect(page).to have_content term1.name
  end
  scenario 'Term名と解説、ジャンルも含めて検索できる' do
    user = FactoryBot.create(:user1)
    genre1 = FactoryBot.create(:genre1)
    genre2 = FactoryBot.create(:genre2)
    genre3 = FactoryBot.create(:genre3)
    term1 = FactoryBot.create(:term1, genre_id: genre1.id)
    term2 = FactoryBot.create(:term2, genre_id: genre2.id)
    term3 = FactoryBot.create(:term3, genre_id: genre3.id)
    # 解説1と2はterm1についている
    description1 = FactoryBot.create(:description1, content: "description1", term_id: term1.id, user_id: user.id)
    description2 = FactoryBot.create(:description2, content: "解説2", term_id: term1.id, user_id: user.id)
    description3 = FactoryBot.create(:description3, content: "解説3", term_id: term2.id, user_id: user.id)
    visit root_path
    click_on '詳細検索'
    fill_in 'テキストを入力...', with: 't', match: :first # 全ての解説
    fill_in '解説から検索', with: '解説' # 解説2と3が絞られるので、term1とterm2に絞られる
    select "#{genre1.name}", from: 'q_genre_id_eq' # genre1に紐付くのはterm1のみなので、ここでterm1に絞られる
    click_on 'search-btn-for-capybara'
    expect(page).to have_content term1.name
    expect(page).not_to have_content term2.name
    expect(page).not_to have_content term3.name
  end

  describe 'ログイン以降' do
    background do # ログインしておく
      @user = FactoryBot.create(:user1)
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on 'login-for-capybara'
    end
    scenario 'Termが登録できる' do
      genre1 = FactoryBot.create(:genre1)
      visit current_path
      term1 = FactoryBot.build(:term1)
      click_on 'Term登録'
      fill_in 'term_name', with: term1.name
      select genre1.name, from: 'term_genre_id'
      click_on '登録'
      term = Term.find_by(name: term1.name)
      expect(page).to have_content '新しくTermを登録しました。'
      expect(current_path).to eq term_path(term)
    end
    scenario '作成者本人はTermが編集できる' do
      term1 = FactoryBot.create(:term1, user_id: @user.id)
      visit term_path(term1)
      click_on '編集'
      fill_in 'edit-term-for-capybara', with: 'term2'
      click_on 'edit-term-btn-for-capybara'
      expect(page).to have_content 'Termを更新しました。'
      expect(page).to have_content 'term2'
      expect(page).not_to have_content 'term1'
    end
  end

  describe '管理者権限' do
    scenario '管理者はTermが削除できる' do
      @user = FactoryBot.create(:user2, admin: true) # 管理者ユーザー
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on 'login-for-capybara'
      term1 = FactoryBot.create(:term1, user_id: @user.id)
      visit term_path(term1)
      click_on '削除'
      expect(page).to have_content 'を削除しました。'
    end
  end
end
