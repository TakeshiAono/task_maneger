require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  describe 'ラベル機能' do
    let!(:user){FactoryBot.create(:user)}
    let!(:task){FactoryBot.create(:task, user: user)}
    let!(:task4){FactoryBot.create(:task4, user: user)}
    let!(:label){FactoryBot.create(:label)}
    let!(:group){FactoryBot.create(:group, task: task, label: label)}
    let!(:group2){FactoryBot.create(:group, task: task4, label: label)}

    before do
      # FactoryBot.create(:third_user)
      # FactoryBot.create(:third_task)
      # FactoryBot.create(:task4)
      # FactoryBot.create(:label)
      # FactoryBot.create(:second_label)
      # FactoryBot.create(:group)
      # FactoryBot.create(:second_group)
      visit login_sessions_path
      fill_in "user[email]", with: 'test@gmail.com'
      fill_in "user[password]", with: 'testpassword'
      click_on "commit"
    end
    context 'タスクを新規作成した時' do
      example '正常にラベルも追加できる' do
        visit new_task_path
        select "low", from:"task[priority]"
        fill_in "task[title]", with:"test"
        select "done", from:"task[status]"
        check "task_label_ids_1"
        click_on "commit"
        expect(page).to have_content 'label1'
      end
    end

    context 'label検索した場合' do
      example '該当タスクを検索できる' do
        visit tasks_path
        select "label1", from: "search[label_search]"
        click_on 'search'
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'label1'
        expect(task_list[0]).not_to have_content 'label2'
      end
    end

  end
end