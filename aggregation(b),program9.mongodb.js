# 1. Create Database

```javascript id="8s0mjq"
use orderDB
```

---

# 2. Create Collection and Insert Documents

```javascript id="5z6ntr"
db.orders.insertMany([
  { user_id: "U1", status: "Completed", order_value: 500 },
  { user_id: "U1", status: "Completed", order_value: 700 },
  { user_id: "U1", status: "Pending", order_value: 300 },
  { user_id: "U2", status: "Completed", order_value: 400 },
  { user_id: "U2", status: "Completed", order_value: 900 },
  { user_id: "U2", status: "Cancelled", order_value: 200 },
  { user_id: "U3", status: "Completed", order_value: 1000 },
  { user_id: "U3", status: "Completed", order_value: 600 }
])
```

---

# 3. Display All Records

```javascript id="5t0oqd"
db.orders.find()
```

---

# STATUS = COMPLETED

---

# 4. Total Order Value for Each User

```javascript id="n9q0lw"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  {
    $group: {
      _id: "$user_id",
      total_order_value: { $sum: "$order_value" }
    }
  }
])
```

---

# 5. Minimum Order Value for Each User

```javascript id="93gtja"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  {
    $group: {
      _id: "$user_id",
      min_order_value: { $min: "$order_value" }
    }
  }
])
```

---

# 6. Maximum Order Value for Each User

```javascript id="p7qz3w"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  {
    $group: {
      _id: "$user_id",
      max_order_value: { $max: "$order_value" }
    }
  }
])
```

---

# 7. Average Order Value for Each User

```javascript id="4rsl1v"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  {
    $group: {
      _id: "$user_id",
      avg_order_value: { $avg: "$order_value" }
    }
  }
])
```

---

# 8. First Order Value for Each User

```javascript id="3jndta"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  {
    $group: {
      _id: "$user_id",
      first_order_value: { $first: "$order_value" }
    }
  }
])
```

---

# 9. Last Order Value for Each User

```javascript id="1mco78"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  {
    $group: {
      _id: "$user_id",
      last_order_value: { $last: "$order_value" }
    }
  }
])
```

---

# 10. Array of Order Values for Each User

```javascript id="ltq2bo"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  {
    $group: {
      _id: "$user_id",
      order_values: { $push: "$order_value" }
    }
  }
])
```

---

# AFTER SORTING RECORDS BY order_value (Ascending)

---

# 11. Total Order Value for Each User

```javascript id="x7bn2p"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $sort: { order_value: 1 } },
  {
    $group: {
      _id: "$user_id",
      total_order_value: { $sum: "$order_value" }
    }
  }
])
```

---

# 12. Average Order Value for Each User

```javascript id="yx5vme"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $sort: { order_value: 1 } },
  {
    $group: {
      _id: "$user_id",
      avg_order_value: { $avg: "$order_value" }
    }
  }
])
```

---

# 13. Minimum Order Value for Each User

```javascript id="l6zc8h"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $sort: { order_value: 1 } },
  {
    $group: {
      _id: "$user_id",
      min_order_value: { $min: "$order_value" }
    }
  }
])
```

---

# 14. Maximum Order Value for Each User

```javascript id="mx7f1q"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $sort: { order_value: 1 } },
  {
    $group: {
      _id: "$user_id",
      max_order_value: { $max: "$order_value" }
    }
  }
])
```

---

# 15. First Order Value for Each User

```javascript id="i2q4am"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $sort: { order_value: 1 } },
  {
    $group: {
      _id: "$user_id",
      first_order_value: { $first: "$order_value" }
    }
  }
])
```

---

# 16. Last Order Value for Each User

```javascript id="k0wjhe"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $sort: { order_value: 1 } },
  {
    $group: {
      _id: "$user_id",
      last_order_value: { $last: "$order_value" }
    }
  }
])
```

---

# 17. Array of Order Values for Each User

```javascript id="x4smyw"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $sort: { order_value: 1 } },
  {
    $group: {
      _id: "$user_id",
      order_values: { $push: "$order_value" }
    }
  }
])
```

---

# WITHOUT CONSIDERING FIRST RECORD ($skip: 1)

---

# 18. Total Order Value for Each User

```javascript id="w8i5fs"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$user_id",
      total_order_value: { $sum: "$order_value" }
    }
  }
])
```

---

# 19. Average Order Value for Each User

```javascript id="s0e8lj"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$user_id",
      avg_order_value: { $avg: "$order_value" }
    }
  }
])
```

---

# 20. Maximum Order Value for Each User

```javascript id="ej4u9q"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$user_id",
      max_order_value: { $max: "$order_value" }
    }
  }
])
```

---

# 21. Minimum Order Value for Each User

```javascript id="9w5q1b"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$user_id",
      min_order_value: { $min: "$order_value" }
    }
  }
])
```

---

# 22. Array of Order Values for Each User

```javascript id="7vxjlp"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$user_id",
      order_values: { $push: "$order_value" }
    }
  }
])
```

---

# 23. First Order Value for Each User

```javascript id="b4q1xu"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$user_id",
      first_order_value: { $first: "$order_value" }
    }
  }
])
```

---

# 24. Last Order Value for Each User

```javascript id="e6lh7j"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$user_id",
      last_order_value: { $last: "$order_value" }
    }
  }
])
```

---

# CONSIDERING FIRST 2 RECORDS ONLY ($limit: 2)

---

# 25. Total Order Value for Each User

```javascript id="x3ou0d"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$user_id",
      total_order_value: { $sum: "$order_value" }
    }
  }
])
```

---

# 26. Average Order Value for Each User

```javascript id="4t1gzc"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$user_id",
      avg_order_value: { $avg: "$order_value" }
    }
  }
])
```

---

# 27. Minimum Order Value for Each User

```javascript id="x9k1cq"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$user_id",
      min_order_value: { $min: "$order_value" }
    }
  }
])
```

---

# 28. Maximum Order Value for Each User

```javascript id="hj4q6z"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$user_id",
      max_order_value: { $max: "$order_value" }
    }
  }
])
```

---

# 29. First Order Value for Each User

```javascript id="n7q2xd"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$user_id",
      first_order_value: { $first: "$order_value" }
    }
  }
])
```

---

# 30. Last Order Value for Each User

```javascript id="l5o0wr"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$user_id",
      last_order_value: { $last: "$order_value" }
    }
  }
])
```

---

# 31. Array of Order Values for Each User

```javascript id="df3t5y"
db.orders.aggregate([
  { $match: { status: "Completed" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$user_id",
      order_values: { $push: "$order_value" }
    }
  }
])
```

---

# INDEXING

---

# 32. Create Index on user_id

```javascript id="9q2jhl"
db.orders.createIndex({ user_id: 1 })
```

---

# 33. Create Compound Index on user_id and status

```javascript id="k6v9ps"
db.orders.createIndex({
  user_id: 1,
  status: 1
})
```

---

# 34. Display All Indexes

```javascript id="m8r0wa"
db.orders.getIndexes()
```

---

# 35. Drop a Specific Index

```javascript id="n2x6qt"
db.orders.dropIndex({ user_id: 1 })
```
