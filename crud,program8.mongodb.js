mongodb
// ==========================================
// CRUD Operations using MongoDB
// Collection Name: student
// ==========================================


// STEP 1: Create Database
use collegeDB


// STEP 2: Create Collection
db.createCollection("student")


// STEP 3: Insert Documents

db.student.insertOne({
    roll_no: 1,
    name: "Rahul",
    age: 20,
    course: "Computer Engineering",
    marks: 85,
    city: "Pune"
})

db.student.insertMany([
{
    roll_no: 2,
    name: "Sneha",
    age: 21,
    course: "IT",
    marks: 90,
    city: "Mumbai"
},
{
    roll_no: 3,
    name: "Amit",
    age: 22,
    course: "E&TC",
    marks: 75,
    city: "Delhi"
},
{
    roll_no: 4,
    name: "Priya",
    age: 20,
    course: "Computer Engineering",
    marks: 95,
    city: "Pune"
}
])


// ==========================================
// READ OPERATIONS
// ==========================================

// Display all records
db.student.find()


// Display formatted records
db.student.find().pretty()


// Find specific fields
db.student.find(
    {},
    {name:1, marks:1, _id:0}
)


// ==========================================
// FILTERING RECORDS
// ==========================================

// Students with marks greater than 80
db.student.find({marks: {$gt: 80}})


// Students from Pune
db.student.find({city: "Pune"})


// Using logical AND operator
db.student.find({
    $and: [
        {marks: {$gt: 80}},
        {city: "Pune"}
    ]
})


// Using logical OR operator
db.student.find({
    $or: [
        {course: "IT"},
        {course: "E&TC"}
    ]
})


// ==========================================
// UPDATE OPERATIONS
// ==========================================

// Update one document
db.student.updateOne(
    {roll_no: 1},
    {$set: {marks: 88}}
)


// Update multiple documents
db.student.updateMany(
    {city: "Pune"},
    {$set: {city: "PCMC"}}
)


// Using save() method
db.student.save({
    roll_no: 5,
    name: "Karan",
    age: 23,
    course: "Mechanical",
    marks: 70,
    city: "Nashik"
})


// ==========================================
// DELETE OPERATIONS
// ==========================================

// Delete one document
db.student.deleteOne({roll_no: 3})


// Delete multiple documents
db.student.deleteMany({marks: {$lt: 75}})


// ==========================================
// SORTING RECORDS
// ==========================================

// Sort by marks ascending
db.student.find().sort({marks: 1})


// Sort by marks descending
db.student.find().sort({marks: -1})


// ==========================================
// INDEXING
// ==========================================

// Create index on name field
db.student.createIndex({name: 1})


// Create compound index
db.student.createIndex({course: 1, marks: -1})


// View indexes
db.student.getIndexes()


// ==========================================
// EXTRA OPERATIONS
// ==========================================

// Count documents
db.student.countDocuments()


// Find top scorer
db.student.find().sort({marks: -1}).limit(1)


// Drop collection
// db.student.drop()


// Drop database
// db.dropDatabase()
