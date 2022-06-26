require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        User.create(id: 1, name: "test")
        task = Task.create(user_id: 1, title: "")
        # user = user.save(name: "a", tasks_attributes: [title: "a"])
        byebug
        # user.create(name: 'a',title:"a")

        # task = user.tasks.save
        # task.save
        byebug

        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # ここに内容を記載する
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        # ここに内容を記載する
      end
    end
  end
end