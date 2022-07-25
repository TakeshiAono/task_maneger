FactoryBot.define do
  factory :user do
    name {'test_user'}
    email {'test@gmail.com'}
    password {'testpassword'}
  end

  factory :admin_user, class: User do
    name {'admin'}
    email {'admin@gmail.com'}
    password {'adminpassword'}
    admin {true}
  end

  factory :second_user, class: User do
    name {'test_user2'}
    email {'test2@gmail.com'}
    password {'testpassword2'}
  end

  factory :third_user, class: User do
    name {'test_user'}
    email {'test@gmail.com'}
    password {'testpassword'}
    id {1}
  end

  factory :second_admin_user, class: User do
    name {'admin2'}
    email {'admin2@gmail.com'}
    password {'admin2password'}
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

  factory :label do
    name {'label1'}
    id {1}
  end

  factory :second_label, class: Label do 
    name {'label2'}
    id {2}
  end

  factory :group do
    # task_id {1}
    # label_id {1}
  end

  factory :second_group, class: Group do
    task_id {2}
    label_id {2}
  end

  factory :third_task, class: Task do
    title {'test3'}
    priority {2}
    deadline {Date.today}
    created_at {Date.today}
    user_id {1}
    id {1}
  end

  factory :task4, class: Task do
    title {'test4'}
    priority {2}
    deadline {Date.today}
    created_at {Date.today}
    # user_id {1}
    # id {2}
  end

end
