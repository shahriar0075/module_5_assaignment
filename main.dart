import 'package:flutter/material.dart';

// A. Abstract class Role
abstract class Role {
  void displayRole();
}

// B. Class Person extending Role
abstract class Person implements Role {
  final String name;
  final int age;
  final String address;

  Person({
    required this.name,
    required this.age,
    required this.address,
  });
}

// C. Class Student extending Person
class Student extends Person {
  final String studentID;
  final String grade;
  final List<double> courseScores;

  Student({
    required String name,
    required int age,
    required String address,
    required this.studentID,
    required this.grade,
    required this.courseScores,
  }) : super(name: name, age: age, address: address);

  @override
  void displayRole() {
    print("Role: Student");
  }

  // Method to calculate average score
  double calculateAverageScore() {
    if (courseScores.isEmpty) return 0.0;
    double sum = courseScores.reduce((a, b) => a + b);
    return sum / courseScores.length;
  }
}

// D. Class Teacher extending Person
class Teacher extends Person {
  final String teacherID;
  final List<String> coursesTaught;

  Teacher({
    required String name,
    required int age,
    required String address,
    required this.teacherID,
    required this.coursesTaught,
  }) : super(name: name, age: age, address: address);

  @override
  void displayRole() {
    print("Role: Teacher");
  }
}

// E. UI Entry Point (StudentManagementSystem App)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Student student;
  late Teacher teacher;

  @override
  void initState() {
    super.initState();

    // Sample Data Setup
    student = Student(
      name: "John Doe",
      age: 20,
      address: "123 Main St",
      studentID: "S101",
      grade: "A",
      courseScores: [90.0, 85.0, 92.0], // Average will be 89.0
    );

    teacher = Teacher(
      name: "Mrs. Smith",
      age: 35,
      address: "456 Oak St",
      teacherID: "T201",
      coursesTaught: ["Math", "English", "Bangla"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management System'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Student Information Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Student Information:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text("Role: Student"),
                    Text("Name: ${student.name}"),
                    Text("Age: ${student.age}"),
                    Text("Address: ${student.address}"),
                    Text("Average Score: ${student.calculateAverageScore().toStringAsFixed(1)}"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Teacher Information Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Teacher Information:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text("Role: Teacher"),
                    Text("Name: ${teacher.name}"),
                    Text("Age: ${teacher.age}"),
                    Text("Address: ${teacher.address}"),
                    const Text("Courses Taught:"),
                    ...teacher.coursesTaught.map((course) => Text("- $course")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}