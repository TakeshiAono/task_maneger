require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let!(:task) { FactoryBot.create(:task)}
  # before do
  #   FactoryBot.create(:user, name: '付け加えた名前１')
  #   FactoryBot.create(:user, name: '付け加えた名前２')
  #   FactoryBot.create(:second_user, name: '付け加えた名前３')
  # end

  # before do
  #   # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
  #   FactoryBot.create(:user)
  #   FactoryBot.create(:second_user)
  # end
  
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        new_task = FactoryBot.create(:task, title:"test_title", priority: 1, deadline: "2022-01-01")
        visit task_path(new_task.id)
        expect(page).to have_content "test_title"
        expect(page).to have_content "2022-01-01"
      end
    end
    context 'タスクを新規新規登録する場合' do
      example '終了期限も登録できる' do
        # visit new_task_path
        # expect().to 


      end
    end
  end

  describe '一覧表示機能' do
    context '終了期限でソートした場合' do
      example '終了期限で降順に一覧が表示される' do
        FactoryBot.create(:task, id: 1, deadline: "2022-01-01")
        FactoryBot.create(:task, id: 2, deadline: "2022-01-02")
        visit tasks_path
        click_on 'Deadline'
        task_list = all('.task_row')
        expect(task_list[2].text).to be >= task_list[6].text
      end
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        FactoryBot.create(:task, title:"test_title", priority: 1, deadline: Date.today)
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'test_title'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, id: 1, created_at: Date.today-1)
        FactoryBot.create(:task, id: 2, created_at: Date.today)
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[3].text).to be >= task_list[7].text
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        # FactoryBot.create(:user, name:"test")
        task = FactoryBot.create(:task, title:"test_title", priority: 1, deadline: Date.today)
        visit task_path(task.id)
        expect(page).to have_content "test_title"
      end
    end
  end
end