- Users
    name:string
    email:string
    password_digest
    image:string
    section:string
- tasks
    user_id:integer
    priority:integer
    name:string
    deadline:date
- groups
    task_id:integer
    label_id:integer
- statuses
    task_id:integer
    name:string
- labels
    name:string