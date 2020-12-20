require 'rails_helper'

RSpec.feature User, type: :feature do
  scenario '新規登録できる' do
    user = FactoryBot.build(:user1)
    visit new_user_registration_path
    fill_in '名前', with: user.name
    fill_in 'プロフィール', with: 'プロフィール本文'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    fill_in '確認用パスワード', with: user.password
    click_on 'Sign up'
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  describe 'ログイン以降' do
    background do # ログインしておく
      user = FactoryBot.create(:user1)
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_on 'login-for-capybara'
    end
    scenario 'ログインできる' do
      expect(page).to have_content 'ログインしました。'
    end
    scenario 'ユーザー情報を編集できる' do
      visit edit_user_registration_path
      fill_in 'メールアドレス', with: '2user1@user1.com'
      fill_in 'パスワード', with: '2user1user1'
      fill_in '確認用パスワード', with: '2user1user1'
      fill_in '現在のパスワード', with: 'user1user1'
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました。'
    end
  end
end
