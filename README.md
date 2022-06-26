- Users
    name:string
    email:string
    password_digest:string
    image:string
    section:string

- tasks
    user_id:bigint
    priority:integer
    name:string
    deadline:date

- groups
    task_id:bigint
    label_id:bigint

- statuses
    task_id:bigint
    name:string

- labels
    name:string