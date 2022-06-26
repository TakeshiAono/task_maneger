FactoryBot.define do
  factory :user do
    name {'aono'}
    id {1}
  end
  factory :task do
    title {'aono title'}
    user_id {1}
    
  end
end
