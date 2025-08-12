import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/courses_provider.dart';
import '../models/course.dart';
import '../utils/app_colors.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Courses Offered')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(coursesProvider);
        },
        child: coursesAsync.when(
          data:
              (courses) => GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.875,
                ),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Course Image
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            course.imageUrl,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 120,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image, size: 50),
                              );
                            },
                          ),
                        ),

                        // Course Name
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            course.name,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text(
                      'Error loading courses',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.refresh(coursesProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  // Widget _buildDetailItem(IconData icon, String label, String value) {
  //   return Row(
  //     children: [
  //       Icon(icon, color: const Color(0xFF1976D2), size: 20),
  //       const SizedBox(width: 8),
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             label,
  //             style: const TextStyle(fontSize: 12, color: Colors.grey),
  //           ),
  //           Text(
  //             value,
  //             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Color _getLevelColor(String level) {
  //   switch (level.toLowerCase()) {
  //     case 'primary':
  //       return AppColors.primary; // Orange
  //     case 'secondary':
  //       return AppColors.secondary; // Blue
  //     case 'higher secondary':
  //       return AppColors.tertiary; // Brown
  //     default:
  //       return Colors.grey;
  //   }
  // }

  // void _showCourseDetails(BuildContext context, Course course) {
  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog(
  //           title: Text(course.name),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   course.description,
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 Text(
  //                   'Duration: ${course.duration}',
  //                   style: const TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 Text(
  //                   'Level: ${course.level}',
  //                   style: const TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 Text(
  //                   'Fee: \$${course.fee.toStringAsFixed(0)}',
  //                   style: const TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 const Text(
  //                   'Subjects:',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 ...course.subjects.map((subject) => Text('• $subject')),
  //               ],
  //             ),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: const Text('Close'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 _showRegistrationDialog(context, course);
  //               },
  //               child: const Text('Apply Now'),
  //             ),
  //           ],
  //         ),
  //   );
  // }

  // void _showRegistrationDialog(BuildContext context, Course course) {
  //   showDialog(
  //     context: context,
  //     builder:
  //         (context) => AlertDialog(
  //           title: const Text('Course Registration'),
  //           content: Text(
  //             'You are about to apply for ${course.name}. This will redirect you to the registration page.',
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(),
  //               child: const Text('Cancel'),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 // Navigate to registration page
  //                 // context.go('/registration');
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text(
  //                       'Registration for ${course.name} will be available soon!',
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: const Text('Continue'),
  //             ),
  //           ],
  //         ),
  //   );
  // }
}
