FactoryBot.define do
  factory :user do
    name {'test_user'}
    email {'test@gmail.com'}
    password {'testpassword'}
    # id {1}
  end

  factory :admin_user, class: User do
    name {'admin'}
    email {'admin@gmail.com'}
    password {'adminpassword'}
    # id {2}
    admin {true}
  end

  factory :second_user, class: User do
    name {'test_user2'}
    email {'test2@gmail.com'}
    password {'testpassword2'}
    # id {3}
  end

  factory :second_admin_user, class: User do
    name {'admin2'}
    email {'admin2@gmail.com'}
    password {'admin2password'}
    # id {4}
    admin {true}
  end

  factory :task do
    title {'aono_title'}
    priority {1}
    deadline {Date.today}
    created_at {Date.today}
    user_id {1}
  end

  factory :second_task, class: Task do
    title {'test2'}
    priority {2}
    deadline {Date.today}
    created_at {Date.today}
    user_id {1}
  end

  factory :status do
    name {'yet'}
  end
end
