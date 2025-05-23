import 'package:flutter/material.dart';

class CrouseCard extends StatelessWidget {
  final String courseName;
  final int credit;
  final double mark;

  const CrouseCard({
    super.key,
    required this.courseName,
    required this.credit,
    required this.mark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: const Icon(Icons.book, color: Colors.deepPurple),
        ),
        title: Text(
          courseName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          'Credit: $credit\nMark: $mark',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            letterSpacing: 0.5,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.deepPurple),
      ),
    );
  }
}
