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

  factory :second_task, class: Task do
    title {'test2'}
    priority {2}
    deadline {Date.today}
    created_at {Date.today}
  end

  factory :status do
    name {'yet'}
  end
end
