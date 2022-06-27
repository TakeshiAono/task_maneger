#### Users
| Columns | Description |
| --- | --- |
| name | string |
|email|string|
|password_digest|string|
|image|string|
|section|string|

#### tasks
| Columns | Description |
| --- | --- |
|user_id|bigint|
|priority|integer|
|name|string|
|deadline|date|

#### groups
| Columns | Description |
| --- | --- |
|task_id|bigint|
|label_id|bigint|

#### statuses
| Columns | Description |
| --- | --- |
|task_id|bigint|
|name|string|

#### labels
| Columns | Description |
| --- | --- |
|name|string|