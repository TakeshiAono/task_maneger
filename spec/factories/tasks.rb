FactoryBot.define do
  factory :user do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    name { 'user_name' }
  end

  factory :second_user, class: User do
    name { 'user_name2' }
  end
end