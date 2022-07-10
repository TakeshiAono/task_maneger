require 'rails_helper'
RSpec.describe 'セッション機能', type: :system do
  describe 'ログイン機能' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:admin_user)
      FactoryBot.create(:second_user)
      visit login_sessions_path
      fill_in "user[email]", with: 'test@gmail.com'
      fill_in "user[password]", with: 'testpassword'
      click_on "commit"
    end
    context 'ログインした場合' do
      example 'ログインでき、マイページに飛べる' do
        expect(current_path).to eq user_path(User.find_by(email: 'test@gmail.com').id)
      end
    end

    context '自分以外のマイページにアクセスした場合' do
      example '強制的にタスク一覧画面に飛ぶ' do
        visit user_path(User.find_by(email: 'test2@gmail.com').id)
        expect(current_path).not_to eq user_path(User.find_by(email: 'test2@gmail.com').id)
        expect(current_path).to eq tasks_path
      end
    end

    context 'ログアウトした場合' do
      example '正常にログアウトできる' do
        click_link 'Logout'
        expect(current_path).to eq login_sessions_path 
      end
    end

  end
end