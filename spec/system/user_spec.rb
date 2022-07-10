require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  describe 'ユーザ新規登録機能' do
    context '一般ユーザーがsign upした場合' do
      example '作成したユーザーが表示される' do
        visit new_user_path
        fill_in "user[name]", with: "test_user"
        fill_in "user[email]", with: "testemail@gmail.com"
        fill_in "user[password]", with: "testpassword"
        fill_in "user[password_confirmation]", with: "testpassword"
        click_on "commit"
        expect(page).to have_content "test_user"
        expect(page).to have_content "testemail@gmail.com"
      end
    end
  end

  describe '未ログインユーザーのアクセス防止機能' do
    context 'ユーザーがログインせずタスク一覧に飛ぼうとした場合' do
      example 'ログイン画面に遷移する' do
        visit tasks_path
        expect(current_path).to eq login_sessions_path
      end
    end
  end
end