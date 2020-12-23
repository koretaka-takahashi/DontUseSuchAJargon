require 'rails_helper'

RSpec.feature Tagging, type: :feature do
  describe 'ログイン以降' do
    background do # ログインしておく
      @user = FactoryBot.create(:user1, admin: true)
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
    scenario 'Term詳細ページでタグ付けできる' do
      visit term_path(@term)
      select 'tag1', from: 'tagging_tag_id'
      click_on 'タグ付けする'
      expect(page).to have_content 'tag1'
    end
    scenario 'タグ詳細ページからタグを外せる' do
      @tagging1 = Tagging.create(tag_id: @tag1.id, term_id: @term.id)
      @tagging2 = Tagging.create(tag_id: @tag2.id, term_id: @term.id)
      @tagging3 = Tagging.create(tag_id: @tag3.id, term_id: @term.id)
      visit genre_tag_path(@genre, @tag1)
      click_on '外す'
      expect(page).to have_content 'タグ tag1を外しました。'
    end
  end
end

