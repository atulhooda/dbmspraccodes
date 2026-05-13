# 1. Create Database

javascript id="g3r9tk"
use salesDB


---

# 2. Create Orders Collection and Insert Documents

```javascript id="h1v8qm"
db.orders.insertMany([
  { cust_id: "C1", status: "A", amount: 100 },
  { cust_id: "C1", status: "A", amount: 200 },
  { cust_id: "C1", status: "B", amount: 300 },
  { cust_id: "C2", status: "A", amount: 400 },
  { cust_id: "C2", status: "A", amount: 150 },
  { cust_id: "C2", status: "B", amount: 250 },
  { cust_id: "C3", status: "A", amount: 500 },
  { cust_id: "C3", status: "A", amount: 350 }
])
```

---

# 3. Display All Records

```javascript id="hwb1al"
db.orders.find()
```

---

# 4. Total Amount for Individual Customer ID having Status A

```javascript id="8e3jkn"
db.orders.aggregate([
  { $match: { status: "A" } },
  {
    $group: {
      _id: "$cust_id",
      total_amount: { $sum: "$amount" }
    }
  }
])
```

---

# 5. Minimum Amount for Individual Customer ID having Status A

```javascript id="a2v7xt"
db.orders.aggregate([
  { $match: { status: "A" } },
  {
    $group: {
      _id: "$cust_id",
      min_amount: { $min: "$amount" }
    }
  }
])
```

---

# 6. Maximum Amount for Individual Customer ID having Status A

```javascript id="6v2qjm"
db.orders.aggregate([
  { $match: { status: "A" } },
  {
    $group: {
      _id: "$cust_id",
      max_amount: { $max: "$amount" }
    }
  }
])
```

---

# 7. Average Amount for Individual Customer ID having Status A

```javascript id="4s1kzw"
db.orders.aggregate([
  { $match: { status: "A" } },
  {
    $group: {
      _id: "$cust_id",
      avg_amount: { $avg: "$amount" }
    }
  }
])
```

---

# 8. Amount of First Record for Individual Customer ID having Status A

```javascript id="6u1nvy"
db.orders.aggregate([
  { $match: { status: "A" } },
  {
    $group: {
      _id: "$cust_id",
      first_amount: { $first: "$amount" }
    }
  }
])
```

---

# 9. Amount of Last Record for Individual Customer ID having Status A

```javascript id="z1o8wf"
db.orders.aggregate([
  { $match: { status: "A" } },
  {
    $group: {
      _id: "$cust_id",
      last_amount: { $last: "$amount" }
    }
  }
])
```

---

# 10. Create Array of Amount for Individual Customer ID having Status A

```javascript id="iy3xpr"
db.orders.aggregate([
  { $match: { status: "A" } },
  {
    $group: {
      _id: "$cust_id",
      amount_array: { $push: "$amount" }
    }
  }
])
```

---

# 11. After Sorting — Total Amount for Individual Customer ID

```javascript id="fj6k2q"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $sort: { amount: 1 } },
  {
    $group: {
      _id: "$cust_id",
      total_amount: { $sum: "$amount" }
    }
  }
])
```

---

# 12. After Sorting — Average Amount for Individual Customer ID

```javascript id="vh8n0m"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $sort: { amount: 1 } },
  {
    $group: {
      _id: "$cust_id",
      avg_amount: { $avg: "$amount" }
    }
  }
])
```

---

# 13. After Sorting — Minimum Amount for Individual Customer ID

```javascript id="rk9dws"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $sort: { amount: 1 } },
  {
    $group: {
      _id: "$cust_id",
      min_amount: { $min: "$amount" }
    }
  }
])
```

---

# 14. After Sorting — Maximum Amount for Individual Customer ID

```javascript id="up1xql"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $sort: { amount: 1 } },
  {
    $group: {
      _id: "$cust_id",
      max_amount: { $max: "$amount" }
    }
  }
])
```

---

# 15. After Sorting — Amount of First Record

```javascript id="1v7dco"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $sort: { amount: 1 } },
  {
    $group: {
      _id: "$cust_id",
      first_amount: { $first: "$amount" }
    }
  }
])
```

---

# 16. After Sorting — Amount of Last Record

```javascript id="t0n9me"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $sort: { amount: 1 } },
  {
    $group: {
      _id: "$cust_id",
      last_amount: { $last: "$amount" }
    }
  }
])
```

---

# 17. After Sorting — Create Array of Amount

```javascript id="c4y0wr"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $sort: { amount: 1 } },
  {
    $group: {
      _id: "$cust_id",
      amount_array: { $push: "$amount" }
    }
  }
])
```

---

# 18. Without First Record — Total Amount

```javascript id="tw0mfs"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$cust_id",
      total_amount: { $sum: "$amount" }
    }
  }
])
```

---

# 19. Without First Record — Average Amount

```javascript id="0u8mle"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$cust_id",
      avg_amount: { $avg: "$amount" }
    }
  }
])
```

---

# 20. Without First Record — Maximum Amount

```javascript id="jlwm31"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$cust_id",
      max_amount: { $max: "$amount" }
    }
  }
])
```

---

# 21. Without First Record — Minimum Amount

```javascript id="a6h7tv"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$cust_id",
      min_amount: { $min: "$amount" }
    }
  }
])
```

---

# 22. Without First Record — Create Array of Amount

```javascript id="m3xjpf"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$cust_id",
      amount_array: { $push: "$amount" }
    }
  }
])
```

---

# 23. Without First Record — Amount of First Record

```javascript id="n2w1zk"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$cust_id",
      first_amount: { $first: "$amount" }
    }
  }
])
```

---

# 24. Without First Record — Amount of Last Record

```javascript id="j0v4as"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $skip: 1 },
  {
    $group: {
      _id: "$cust_id",
      last_amount: { $last: "$amount" }
    }
  }
])
```

---

# 25. First 2 Records Only — Total Amount

```javascript id="x4h7la"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$cust_id",
      total_amount: { $sum: "$amount" }
    }
  }
])
```

---

# 26. First 2 Records Only — Average Amount

```javascript id="9d7mte"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$cust_id",
      avg_amount: { $avg: "$amount" }
    }
  }
])
```

---

# 27. First 2 Records Only — Minimum Amount

```javascript id="0c5yzp"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$cust_id",
      min_amount: { $min: "$amount" }
    }
  }
])
```

---

# 28. First 2 Records Only — Maximum Amount

```javascript id="r5b1ho"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$cust_id",
      max_amount: { $max: "$amount" }
    }
  }
])
```

---

# 29. First 2 Records Only — Amount of First Record

```javascript id="a7d3lj"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$cust_id",
      first_amount: { $first: "$amount" }
    }
  }
])
```

---

# 30. First 2 Records Only — Amount of Last Record

```javascript id="6t1nqy"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$cust_id",
      last_amount: { $last: "$amount" }
    }
  }
])
```

---

# 31. First 2 Records Only — Create Array of Amount

```javascript id="kw2vbm"
db.orders.aggregate([
  { $match: { status: "A" } },
  { $limit: 2 },
  {
    $group: {
      _id: "$cust_id",
      amount_array: { $push: "$amount" }
    }
  }
])

