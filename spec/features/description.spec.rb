require 'rails_helper'

RSpec.feature Description, type: :feature do
  scenario 'Term詳細ページでTermを選択すると詳細ページに遷移しそのTermの解説一覧が表示される' do
    genre = FactoryBot.create(:genre1)
    user = FactoryBot.create(:user1)
    term = FactoryBot.create(:term1, genre_id: genre.id)
    description = FactoryBot.create(:description1, content: "description1", term_id: term.id, user_id: user.id)
    comment1 = FactoryBot.create(:comment1, user_id: user.id, description_id: description.id)
    comment2 = FactoryBot.create(:comment2, user_id: user.id, description_id: description.id)
    visit term_path(term)
    click_on "description-#{description.id}-for-capybara"
    expect(page).to have_content comment1.content
    expect(page).to have_content comment2.content
  end

  describe 'ログイン以降' do
    background do # ログインしておく
      @user = FactoryBot.create(:user1)
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on 'login-for-capybara'
    end
    scenario '解説を登録できる' do
      term1 = FactoryBot.create(:term1)
      visit term_path(term1)
      click_on '解説する'
      fill_in 'description_content', with: "test_description"
      click_on 'description-submit-for-capybara'
      expect(page).to have_content '解説を投稿しました。'
      expect(page).to have_content 'test_description'
    end
    scenario '投稿者本人は解説を編集できる' do
      term1 = FactoryBot.create(:term1)
      description1 = FactoryBot.create(:description1, user_id: @user.id, term_id: term1.id)
      visit term_description_path(term1, description1)
      click_on '編集'
      fill_in 'description_content', with: 'description1(更新済み)'
      click_on 'description-submit-for-capybara'
      expect(page).to have_content '解説を更新しました。'
      expect(page).to have_content 'description1(更新済み)'
    end
    scenario '投稿者本人は解説を削除できる' do
      term1 = FactoryBot.create(:term1)
      description1 = FactoryBot.create(:description1, user_id: @user.id, term_id: term1.id)
      visit term_description_path(term1, description1)
      click_on '削除'
      expect(page).to have_content '解説を削除しました。'
      expect(page).not_to have_content description1.content
    end
  end
  describe '管理者権限' do
    scenario '管理者は投稿者以外でも解説を削除できる' do
      user1 = FactoryBot.create(:user1) # 一般ユーザー
      user2 = FactoryBot.create(:user2, admin: true) # 管理者ユーザー
      visit new_user_session_path
      fill_in 'メールアドレス', with: user2.email
      fill_in 'パスワード', with: user2.password
      click_on 'login-for-capybara' # 管理者ログイン完了
      term1 = FactoryBot.create(:term1)
      description1 = FactoryBot.create(:description1, user_id: user1.id, term_id: term1.id) # 一般ユーザーが解説投稿者
      visit term_description_path(term1, description1)
      click_on '削除'
      expect(page).to have_content '解説を削除しました。'
      expect(page).not_to have_content description1.content
    end
  end
end
