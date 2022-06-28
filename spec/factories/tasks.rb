FactoryBot.define do
  factory :user do
    name {'aono'}
    id {1}
  end
  factory :task do
    title {'aono_title'}
    priority {1}
    deadline {Date.today}
    created_at {Date.today}
  end
end
