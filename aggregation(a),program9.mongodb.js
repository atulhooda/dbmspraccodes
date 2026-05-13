Here’s a complete MongoDB example for **Aggregation and Indexing in MongoDB** using an `employee` collection.

---

# 1. Create Database

```javascript id="spdtpk"
use companyDB
```

---

# 2. Create Employee Collection and Insert Records

```javascript id="n1u3zs"
db.employee.insertMany([
  { emp_id: 1, name: "Amit", department: "HR", salary: 30000, city: "Pune" },
  { emp_id: 2, name: "Rohit", department: "IT", salary: 50000, city: "Mumbai" },
  { emp_id: 3, name: "Sneha", department: "Finance", salary: 45000, city: "Delhi" },
  { emp_id: 4, name: "Priya", department: "IT", salary: 60000, city: "Pune" },
  { emp_id: 5, name: "Karan", department: "HR", salary: 35000, city: "Loni" },
  { emp_id: 6, name: "Neha", department: "Finance", salary: 55000, city: "Mumbai" },
  { emp_id: 7, name: "Arjun", department: "IT", salary: 70000, city: "Pune" },
  { emp_id: 8, name: "Riya", department: "HR", salary: 32000, city: "Delhi" }
])
```

---

# 3. Display All Records

```javascript id="6dth5s"
db.employee.find()
```

---

# 4. Aggregation — Filtering Records

## Employees with salary greater than 40000

```javascript id="t17hlz"
db.employee.aggregate([
  {
    $match: { salary: { $gt: 40000 } }
  }
])
```

---

# 5. Aggregation — Grouping Records

## Group employees by department and calculate total salary

```javascript id="d3wht4"
db.employee.aggregate([
  {
    $group: {
      _id: "$department",
      total_salary: { $sum: "$salary" },
      average_salary: { $avg: "$salary" },
      employee_count: { $sum: 1 }
    }
  }
])
```

---

# 6. Aggregation — Sorting Records

## Sort employees by salary in ascending order

```javascript id="0oqv5k"
db.employee.aggregate([
  {
    $sort: { salary: 1 }
  }
])
```

## Descending order

```javascript id="t7wk0k"
db.employee.aggregate([
  {
    $sort: { salary: -1 }
  }
])
```

---

# 7. Aggregation — Skipping Records

## Skip first 3 records

```javascript id="k1m7g9"
db.employee.aggregate([
  {
    $skip: 3
  }
])
```

---

# 8. Aggregation — Limiting Records

## Display first 5 records only

```javascript id="d5hmwd"
db.employee.aggregate([
  {
    $limit: 5
  }
])
```

---

# 9. Combined Aggregation Example

## Filter IT department → Sort by salary → Limit 2 records

```javascript id="shd6w0"
db.employee.aggregate([
  {
    $match: { department: "IT" }
  },
  {
    $sort: { salary: -1 }
  },
  {
    $limit: 2
  }
])
```

---

# 10. Create Index on emp_id

```javascript id="0bhg4z"
db.employee.createIndex({ emp_id: 1 })
```

---

# 11. Create Compound Index

## Index on department and salary

```javascript id="o3m8wp"
db.employee.createIndex({
  department: 1,
  salary: -1
})
```

---

# 12. Show All Indexes

```javascript id="4r9xux"
db.employee.getIndexes()
```

---

# 13. Delete Employee Collection

```javascript id="br2xev"
db.employee.drop()
```

---

# 14. Show Collections

```javascript id="mzjlwm"
show collections
```

---

# 15. Exit MongoDB

```javascript id="j4g2xk"
exit
```
