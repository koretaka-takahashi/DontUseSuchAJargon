require 'rails_helper'

RSpec.feature Like, type: :feature do
  describe 'ログイン以降' do
    background do # ログインしておく
      @user = FactoryBot.create(:user1, admin: true)
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_on 'login-for-capybara'
      @genre = FactoryBot.create(:genre1)
      @term = FactoryBot.create(:term1, genre_id: @genre.id)
      @description1 = FactoryBot.create(:description1, term_id: @term.id, user_id: @user.id)
      @description2 = FactoryBot.create(:description2, term_id: @term.id, user_id: @user.id)
      @description3 = FactoryBot.create(:description3, term_id: @term.id, user_id: @user.id)
    end
    scenario '解説一覧からいいね！できる'
      # visit term_path(@term)
      
      # click_on "like-#{@description1.id}-for-capybara"
      # expect(page).not_to have_content 'description1'

    scenario '解説一覧からいいね！を外せる'
    scenario '解説詳細ページからいいね！できる' do
      visit term_description_path(@term, @description3)
      save_and_open_page

      click_on "capybara"
      expect(page).has_css ('.fas')
    end

    scenario '解説を登録できる'
  end
end
 # save_and_open_page
 # JSのテストは書かなくて良いとのことなので保留
