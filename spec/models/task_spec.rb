require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe '検索機能' do
    let!(:task){FactoryBot.create(:task, title: "test", status: "done")}
    let!(:second_task){FactoryBot.create(:second_task, title: 'sample', status: "not_yet")}
    context 'scopメソッドでstatustとtitleのand検索をした場合' do
      it '検索キーワードを含むsutatusとtitleが絞り込まれる' do
        expect(Task.search("status", "done").search("title", "test")).to include(task)
        expect(Task.search("status", "done").search("title", "test")).not_to include(second_task)
        expect(Task.search("status", "done").search("title", "test").count).to eq 1
      end
    end
    context 'scopメソッドでstatusのあいまい検索をした場合' do
      it '検索キーワードを含むsutatusが絞り込まれる' do
        expect(Task.search("status", "done")).to include(task)
        expect(Task.search("status", "done")).not_to include(second_task)
        expect(Task.search("status", "done").count).to eq 1
      end
    end
    context 'scopメソッドでタイトルのあいまい検索をした場合' do
      it '検索キーワードを含むタスクが絞り込まれる' do
        expect(Task.search("title", "test")).to include(task)
        expect(Task.search("title", "test")).not_to include(second_task)
        expect(Task.search("title", "test").count).to eq 1
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

        task = FactoryBot.create(:task, deadline: '2022_07_03', status: '未着手' )
               FactoryBot.create(:task, title: "test", status: "done")
      end
    end
  end
end