# Object Dashboard

Try it now at: http://object-dashboard.herokuapp.com

# Features

• Allows users to upload CSV files containing object transaction records.

Required headers: `object_id, object_type, timestamp, object_changes` in any order!

  - Blanks, duplicates and existing saved records are not allowed.

• Allows users to query for snapshots of objects at a certain point in time.

  - If left blank, the search will return the current status of the object.

• Flushing the DB is available for easy testing!

Enjoy!