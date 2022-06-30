require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    let!(:task){FactoryBot.create(:task, title: "test")}
    let!(:second_task){FactoryBot.create(:second_task, title: 'sample')}
    context 'scopメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.title_search("test")).to include(task)
        expect(Task.title_search("test")).not_to include(second_task)
        expect(Task.title_search("test").count).to eq 1
      end
    end
  end
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        # task = User.create(name: "test", tasks_attributes: [{title: nil, priority: 1, deadline:Date.today}])
        task = Task.create(title: nil, priority: 1, deadline: Date.today)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # priority = User.create(name: "test", tasks_attributes: [{title: "test", priority: nil , deadline:Date.today}])
        # deadline = User.create(name: "test", tasks_attributes: [{title: "test", priority: 1, deadline: nil}])
        priority = Task.create(title: 'test', priority: nil, deadline: Date.today)
        deadline = Task.create(title: 'test', priority: 1, deadline: nil)
        expect(priority).not_to be_valid
        expect(deadline).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # task = User.create(name: "test", tasks_attributes: [{title: "test", priority: 1, deadline: Date.today}])
        task = Task.create(title: 'test', priority: 1, deadline: Date.today)
        # expect(task).to be_valid
        expect(task).to be_valid
      end
    end
  end
end