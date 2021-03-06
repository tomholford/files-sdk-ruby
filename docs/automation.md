# Automation

## Example Automation Object

```
{
  "id": 1,
  "automation": "create_folder",
  "source": "",
  "destination": "",
  "destination_replace_from": "",
  "destination_replace_to": "",
  "interval": "week",
  "next_process_on": "2020-01-01",
  "path": "",
  "realtime": true,
  "user_id": 1,
  "user_ids": [

  ],
  "group_ids": [

  ]
}
```

* `id` (int64): Automation ID
* `automation` (string): Automation type
* `source` (string): Source Path
* `destination` (string): Destination Path
* `destination_replace_from` (string): If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
* `destination_replace_to` (string): If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
* `interval` (string): How often to run this automation?  One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
* `next_process_on` (string): Date this automation will next run.
* `path` (string): Path on which this Automation runs.  Supports globs. This must be slash-delimited, but it must neither start nor end with a slash. Maximum of 5000 characters.
* `realtime` (boolean): Does this automation run in real time?  This is a read-only property based on automation type.
* `user_id` (int64): User ID of the Automation's creator.
* `user_ids` (array): IDs of Users for the Automation (i.e. who to Request File from)
* `group_ids` (array): IDs of Groups for the Automation (i.e. who to Request File from)


---

## List Automations

```
Files::Automation.list(
  page: 1, 
  per_page: 1, 
  automation: "create_folder"
)
```

### Parameters

* `page` (int64): Current page number.
* `per_page` (int64): Number of records to show per page.  (Max: 10,000, 1,000 or less is recommended).
* `action` (string): Deprecated: If set to `count` returns a count of matching records rather than the records themselves.
* `automation` (string): Type of automation to filter by.


---

## Show Automation

```
Files::Automation.find(id)
```

### Parameters

* `id` (int64): Required - Automation ID.


---

## Create Automation

```
Files::Automation.create(
  automation: "create_folder", 
  source: "source", 
  destination: "destination", 
  interval: "year"
)
```

### Parameters

* `automation` (string): Required - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
* `source` (string): Source Path
* `destination` (string): Destination Path
* `destination_replace_from` (string): If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
* `destination_replace_to` (string): If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
* `interval` (string): How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
* `path` (string): Path on which this Automation runs.  Supports globs.
* `user_ids` (string): A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
* `group_ids` (string): A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.


---

## Update Automation

```
Files::Automation.update(id, 
  automation: "create_folder", 
  source: "source", 
  destination: "destination", 
  interval: "year"
)
```

### Parameters

* `id` (int64): Required - Automation ID.
* `automation` (string): Required - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
* `source` (string): Source Path
* `destination` (string): Destination Path
* `destination_replace_from` (string): If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
* `destination_replace_to` (string): If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
* `interval` (string): How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
* `path` (string): Path on which this Automation runs.  Supports globs.
* `user_ids` (string): A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
* `group_ids` (string): A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.


---

## Delete Automation

```
Files::Automation.delete(id)
```

### Parameters

* `id` (int64): Required - Automation ID.


---

## Update Automation

```
automation = Files::Automation.find(1)
automation.update(
  automation: "create_folder",
  source: "source",
  destination: "destination",
  interval: "year"
)
```

### Parameters

* `id` (int64): Required - Automation ID.
* `automation` (string): Required - Type of automation.  One of: `create_folder`, `request_file`, `request_move`
* `source` (string): Source Path
* `destination` (string): Destination Path
* `destination_replace_from` (string): If set, this string in the destination path will be replaced with the value in `destination_replace_to`.
* `destination_replace_to` (string): If set, this string will replace the value `destination_replace_from` in the destination filename. You can use special patterns here.
* `interval` (string): How often to run this automation? One of: `day`, `week`, `week_end`, `month`, `month_end`, `quarter`, `quarter_end`, `year`, `year_end`
* `path` (string): Path on which this Automation runs.  Supports globs.
* `user_ids` (string): A list of user IDs the automation is associated with. If sent as a string, it should be comma-delimited.
* `group_ids` (string): A list of group IDs the automation is associated with. If sent as a string, it should be comma-delimited.


---

## Delete Automation

```
automation = Files::Automation.find(1)
automation.delete
```

### Parameters

* `id` (int64): Required - Automation ID.
