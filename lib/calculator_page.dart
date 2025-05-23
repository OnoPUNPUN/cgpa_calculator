import 'package:cgpa_calculator/cgpa_page.dart';
import 'package:cgpa_calculator/widgets/crouse_card.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController crouseNameController = TextEditingController();
  final TextEditingController creaditController = TextEditingController();
  final TextEditingController markController = TextEditingController();

  final List<Map<String, dynamic>> courses = [];

  @override
  void dispose() {
    crouseNameController.dispose();
    creaditController.dispose();
    markController.dispose();
    super.dispose();
  }

  void _addCourse() {
    final name = crouseNameController.text.trim();
    final credit = int.tryParse(creaditController.text.trim());
    final markPerSub = double.tryParse(markController.text.trim());

    if (name.isNotEmpty && credit != null && markPerSub != null) {
      setState(() {
        courses.add({'name': name, 'credit': credit, 'mark': markPerSub});
      });
      crouseNameController.clear();
      creaditController.clear();
      markController.clear();
    }
  }

  double _gpa(double marks) {
    if (marks >= 90 && marks <= 100) {
      return 4.0;
    } else if (marks >= 85 && marks < 90) {
      return 3.75;
    } else if (marks >= 80 && marks < 85) {
      return 3.50;
    } else if (marks >= 75 && marks < 80) {
      return 3.25;
    } else if (marks >= 70 && marks < 75) {
      return 3.00;
    } else {
      return 0.0;
    }
  }

  double _calculateCGPA() {
    double totalMarks = 0.0;
    double totalCredits = 0.0;

    for (var course in courses) {
      final double mark = course['mark'];
      final double credit = course['credit'].toDouble();
      totalMarks += _gpa(mark) * credit;
      totalCredits += credit;
    }
    if (totalCredits == 0) return 0.0;
    return totalMarks / totalCredits;
  }

  // double _calculateTotalMarks() {
  //   double totalMarks = 0.0;
  //   for (var course in courses) {
  //     final double mark = course['mark'];
  //     final double credit = course['credit'].toDouble();
  //     totalMarks += _gpa(mark) * credit;
  //   }
  //   return totalMarks;
  // }

  double _calculateTotalCredits() {
    double totalCredits = 0.0;
    for (var course in courses) {
      totalCredits += course['credit'].toDouble();
    }
    return totalCredits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade400.withValues(alpha: 0.9),
        elevation: 0,
        title: const Text(
          'CGPA Calculator',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: [
          FloatingActionButton(
            onPressed: _addCourse,
            backgroundColor: Colors.deepPurple,
            tooltip: 'Add Course',
            child: const Icon(Icons.add, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade700,
                foregroundColor: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
              ),
              onPressed: () {
                final cgpa = _calculateCGPA();
                // final marks = _calculateTotalMarks();
                final credits = _calculateTotalCredits();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CgpaPage(
                          cgpa: cgpa,
                          // marks: marks,
                          credits: credits,
                        ),
                  ),
                );
              },
              child: const Text(
                'Show CGPA',
                style: TextStyle(fontSize: 16, letterSpacing: 1.1),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD1C4E9), Color(0xFFEDE7F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: crouseNameController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.book_rounded,
                              color: Colors.deepPurple,
                            ),
                            hintText: 'Enter Course Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: creaditController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.confirmation_number,
                              color: Colors.deepPurple,
                            ),
                            hintText: 'Enter Number of Credits',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: markController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.grade,
                              color: Colors.deepPurple,
                            ),
                            hintText: 'Enter Mark',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child:
                      courses.isEmpty
                          ? Center(
                            child: Text(
                              'No courses added yet!',
                              style: TextStyle(
                                color: Colors.deepPurple.shade200,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                          : ListView.separated(
                            itemBuilder: (context, index) {
                              final course = courses[index];
                              return CrouseCard(
                                courseName: course['name'],
                                credit: course['credit'],
                                mark: course['mark'],
                              );
                            },
                            separatorBuilder:
                                (context, index) =>
                                    const SizedBox(height: 12.0),
                            itemCount: courses.length,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
