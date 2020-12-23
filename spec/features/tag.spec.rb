require 'rails_helper'

RSpec.feature Tag, type: :feature do
  describe 'ログイン以降' do
    background do # ログインしておく
      @user = FactoryBot.create(:user1)
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on 'login-for-capybara'
      @genre = FactoryBot.create(:genre1)
      @term = FactoryBot.create(:term1, genre_id: @genre.id)
      @tag1 = FactoryBot.create(:tag1, genre_id: @genre.id, user_id: @user.id)
      @tag2 = FactoryBot.create(:tag2, genre_id: @genre.id, user_id: @user.id)
      @tag3 = FactoryBot.create(:tag3, genre_id: @genre.id, user_id: @user.id)
    end
    scenario '特定ジャンル内のタグ一覧ページでタグを追加できる' do
      visit genre_tags_path(@genre)
      click_on "add-tag-for-capybara"
      fill_in 'tag_name', with: 'tag4'
      click_on 'tag-submit-for-capybara'
      expect(page).to have_content 'タグを登録しました。'
      expect(page).to have_content 'tag1'
      expect(page).to have_content 'tag2'
      expect(page).to have_content 'tag3'
      expect(page).to have_content 'tag4'
    end
  end
end

