require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:admin_user){FactoryBot.create(:admin_user)}
  let!(:second_user){FactoryBot.create(:second_user)}
  before do
    visit login_sessions_path
    fill_in "user[email]", with: 'test@gmail.com'
    fill_in "user[password]", with: 'testpassword'
    click_on "commit"
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規新作成した場合' do
      example '作成したタスクが表示される' do
        visit new_task_path
        select "low", from:"task[priority]"
        fill_in "task[title]", with:"test"
        select "done", from:"task[status]"
        click_on "commit"
        expect(all('.show_value')[0].text).to have_content "low"
        expect(all('.show_value')[1].text).to have_content 'test'
        expect(all('.show_value')[2].text).to have_content Date.today
        expect(all('.show_value')[3].text).to have_content "done"
      end
    end
  end

  describe '一覧表示機能' do
    context '優先順位でソートした場合' do
      example '正しい検索結果が表示される' do
        FactoryBot.create(:task, id: 1, title: "test", priority: 1, user: user)
        byebug
        FactoryBot.create(:task, id: 2, title: "test2", priority: 2, user: user)
        FactoryBot.create(:task, id: 3, title: "test3", priority: 3, user: user)
        visit tasks_path
        click_on 'Priority'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'high'
        expect(task_list[1]).to have_content 'middle'
        expect(task_list[2]).to have_content 'low'
      end
    end
    context 'statusとtitleでand検索した場合' do
      example '正しい検索結果が表示される' do
        FactoryBot.create(:task, id: 1, title: "test", status: "done", user: user)
        FactoryBot.create(:task, id: 2, title: "I have a pen", status: "done", user: user)
        FactoryBot.create(:task, id: 3, title: "test", status: "not_yet", user: user)
        FactoryBot.create(:task, id: 4, title: "I have a pen", status:"not_yet", user: user)
        visit tasks_path
        fill_in "search[title_search]", with: "test"
        select "done", from: "search[status_search]"
        click_on 'search'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test'
        expect(task_list[0]).to have_content 'done'
        expect(task_list[1]).to have_content ''
      end
    end
    context 'statusで完全一致検索した場合' do
      example '正しい検索結果が表示される' do
        FactoryBot.create(:task, id: 1, title: "test", status: "done", user: user)
        FactoryBot.create(:task, id: 2, title: "I have a pen", status:"not_yet", user: user)
        visit tasks_path
        select "done", from: "search[status_search]"
        click_on 'search'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test'
        expect(task_list[1]).to have_content ''
      end
    end
    context 'タイトルであいまい検索した場合' do
      example '正しい検索結果が表示される' do
        FactoryBot.create(:task, id: 1, title: "test", user: user)
        FactoryBot.create(:task, id: 2, title: "I have a pen", user: user)
        visit tasks_path
        fill_in "search[title_search]", with: "test"
        click_on 'search'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'test'
        expect(task_list[1]).to have_content ''
      end
    end
    context '終了期限でソートした場合' do
      example '終了期限で降順に一覧が表示される' do
        FactoryBot.create(:task, id: 1, deadline: "2022-01-01", user: user)
        FactoryBot.create(:task, id: 2, deadline: "2022-01-02", user: user)
        visit tasks_path
        click_on 'Deadline'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content '2022-01-02'
        expect(task_list[1]).to have_content '2022-01-01'
      end
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        FactoryBot.create(:task, title:"test_title", priority: 1, deadline: Date.today, user: user)
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, id: 1, created_at: Date.today-1, user: user)
        FactoryBot.create(:task, id: 2, created_at: Date.today, user: user)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content Date.today
        expect(task_list[1]).to have_content Date.today-1
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title:"test_title", priority: 1, deadline: Date.today, user: user)
        visit task_path(task.id)
        expect(page).to have_content "test_title"
      end
    end
  end
end