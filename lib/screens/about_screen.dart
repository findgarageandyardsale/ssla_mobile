import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/school_provider.dart';
import '../providers/testimonials_provider.dart';
import '../utils/app_colors.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schoolInfoAsync = ref.watch(schoolProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(schoolProvider);
          ref.refresh(testimonialsProvider);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Hero Section
              Container(
                width: double.infinity,
                height: 200,
                // decoration: const BoxDecoration(
                //   gradient: AppColors.primaryGradient,
                // ),
                child: schoolInfoAsync.when(
                  data:
                      (schoolInfo) => Image.asset(
                        'assets/about_us.png',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                  loading:
                      () => const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                  error:
                      (error, stack) => const Center(
                        child: Text(
                          'Error loading school info',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                ),
              ),

              // School Description
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: schoolInfoAsync.when(
                  data:
                      (schoolInfo) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About Our School',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            schoolInfo.aboutUsDescription,
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) => const Text('Error loading description'),
                ),
              ),

              // Philosophy Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: schoolInfoAsync.when(
                  data:
                      (schoolInfo) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'A Nurturing Environment for Lifelong Learning Since 1997',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                schoolInfo.aboutUsNurturing,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) => const Text('Error loading philosophy'),
                ),
              ),
              // Philosophy Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: schoolInfoAsync.when(
                  data:
                      (schoolInfo) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Weekly Schedule',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                schoolInfo.aboutUsWeeklySchedule,
                                style: const TextStyle(fontSize: 16),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) => const Text('Error loading philosophy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to get initials from a name
  String _getInitials(String name) {
    if (name.isEmpty) return '';

    final nameParts = name.trim().split(' ');
    if (nameParts.length == 1) {
      return nameParts[0].substring(0, 1).toUpperCase();
    } else if (nameParts.length >= 2) {
      return '${nameParts[0].substring(0, 1)}${nameParts[1].substring(0, 1)}'
          .toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
