require 'rails_helper'
RSpec.describe '管理画面機能', type: :system do
  describe 'アクセス機能' do
    before do
      FactoryBot.create(:admin_user)
      FactoryBot.create(:second_admin_user)
      FactoryBot.create(:user)
      FactoryBot.create(:second_user)
      visit login_sessions_path
      fill_in "user[email]", with: 'admin@gmail.com'
      fill_in "user[password]", with: 'adminpassword'
      click_on "commit"
    end

    context '管理ユーザーが管理画面にアクセスした時' do
      before do
        visit admin_users_path
      end
      example '正常に管理画面にアクセスできる' do
        expect(current_path).to eq admin_users_path
      end

      example '管理ユーザーはユーザーの新規登録ができる' do
        click_link 'New User'
        fill_in "user[name]", with: "new_test_user"
        fill_in "user[email]", with: "new_testemail@gmail.com"
        fill_in "user[password]", with: "new_testpassword"
        fill_in "user[password_confirmation]", with: "new_testpassword"
        click_on "commit"
        expect(page).to have_content "new_test_user"
      end

      example '管理ユーザーはユーザーのマイページにアクセスできる' do
        visit admin_users_path(User.find_by(name: 'test_user').id)
        expect(page).to have_content "test_user"
      end

      example '管理ユーザーはユーザーのマイページでユーザーを編集できる' do
        visit admin_users_path(User.find_by(name: 'test_user').id)
        click_link "Edit", href:edit_admin_user_path(User.find_by(name: 'test_user').id)
        fill_in "user[name]", with: "update_test_user"
        click_on "commit"
        expect(page).to have_content "update_test_user"
      end
      
      example '管理ユーザーはユーザーを削除できる' do
        click_link "Destroy", href:admin_user_path(User.find_by(email: 'test@gmail.com').id)
        # page.accept_confirm "Are you sure?"
        # expect(page).to have_content "Task was successfully destroyed."
        expect(page).not_to have_content "test@gmail.com"
      end

    end

    context '管理ユーザー以外が管理画面にアクセスした時' do
      before do
        click_link 'Logout'
        visit login_sessions_path
        fill_in "user[email]", with: 'test@gmail.com'
        fill_in "user[password]", with: 'testpassword'
        click_on "commit"
      end
      example '管理画面へのアクセスを防げる' do
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
        expect(current_path).to eq tasks_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end

  end
end