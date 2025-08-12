import 'package:flutter/material.dart';

class CoursesSelectionWidget extends StatefulWidget {
  final List<String> courses;
  final List<String> selectedCourseIds;
  final Function(List<String>) onCoursesChanged;

  const CoursesSelectionWidget({
    super.key,
    required this.courses,
    required this.selectedCourseIds,
    required this.onCoursesChanged,
  });

  @override
  State<CoursesSelectionWidget> createState() => _CoursesSelectionWidgetState();
}

class _CoursesSelectionWidgetState extends State<CoursesSelectionWidget> {
  late List<String> _selectedCourseIds;

  @override
  void initState() {
    super.initState();
    _selectedCourseIds = List.from(widget.selectedCourseIds);
  }

  @override
  void didUpdateWidget(CoursesSelectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCourseIds != widget.selectedCourseIds) {
      _selectedCourseIds = List.from(widget.selectedCourseIds);
    }
  }

  void _toggleCourse(String courseName) {
    setState(() {
      if (_selectedCourseIds.contains(courseName)) {
        _selectedCourseIds.remove(courseName);
      } else {
        _selectedCourseIds.add(courseName);
      }
    });
    widget.onCoursesChanged(_selectedCourseIds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // Light cream color
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.book_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Select Courses',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Required field indicator
          Row(
            children: [
              const Text(
                'Courses',
                style: TextStyle(fontSize: 14, color: Color(0xFF424242)),
              ),
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Course checkboxes
          ...widget.courses.map((course) => _buildCourseCheckbox(course)),

          // Selection summary
          if (_selectedCourseIds.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.blue[700], size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Selected: ${_selectedCourseIds.length} course(s)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCourseCheckbox(String courseName) {
    final isSelected = _selectedCourseIds.contains(courseName);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (value) => _toggleCourse(courseName),
            activeColor: Colors.blue,
            checkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              courseName,
              style: TextStyle(
                fontSize: 16,
                color: const Color(0xFF424242),
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
