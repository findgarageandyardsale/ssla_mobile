import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rules & Regulations')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rule, size: 50, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'School Rules & Regulations',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Rules Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRulesSection('General Conduct', Icons.people, [
                    'Students must maintain discipline and decorum at all times.',
                    'Respect for teachers, staff, and fellow students is mandatory.',
                    'Use of inappropriate language or behavior is strictly prohibited.',
                    'Students must follow the school dress code.',
                    'Mobile phones and electronic devices are not allowed during class hours.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection('Academic Rules', Icons.school, [
                    'Regular attendance is compulsory for all students.',
                    'Students must complete all assignments and homework on time.',
                    'Cheating or plagiarism will result in severe disciplinary action.',
                    'Students must maintain academic integrity in all activities.',
                    'Regular participation in class discussions is expected.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection('Attendance & Punctuality', Icons.access_time, [
                    'Students must arrive at school 10 minutes before the first bell.',
                    'Late arrival will be recorded and may affect attendance.',
                    'Absence from school requires a written explanation from parents.',
                    'Medical certificates are required for absences longer than 3 days.',
                    'Students must attend all mandatory school events and functions.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection('Dress Code', Icons.checkroom, [
                    'Students must wear the complete school uniform.',
                    'Uniform must be clean, pressed, and properly fitted.',
                    'Hair should be neat and well-groomed.',
                    'No jewelry or accessories except those specified by the school.',
                    'Sports shoes are only allowed during physical education classes.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection('Library Rules', Icons.library_books, [
                    'Maintain silence in the library at all times.',
                    'Books must be handled with care and returned on time.',
                    'No food or drinks are allowed in the library.',
                    'Students must follow the borrowing rules and limits.',
                    'Damaged books must be reported immediately.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection(
                    'Sports & Physical Education',
                    Icons.sports,
                    [
                      'Participation in physical education is mandatory.',
                      'Students must wear appropriate sports attire.',
                      'Follow safety guidelines for all sports activities.',
                      'Sports equipment must be used responsibly.',
                      'Respect for coaches and fellow players is essential.',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildRulesSection('Cafeteria & Food', Icons.restaurant, [
                    'Maintain cleanliness in the cafeteria area.',
                    'No food wastage is allowed.',
                    'Follow the designated lunch break schedule.',
                    'Students must queue properly for food service.',
                    'Report any food-related issues to the staff immediately.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection('Transportation', Icons.directions_bus, [
                    'Students using school transport must follow bus rules.',
                    'Maintain discipline while boarding and alighting.',
                    'No eating or drinking on the bus.',
                    'Follow the designated pickup and drop-off times.',
                    'Report any transport-related issues to the transport coordinator.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection('Disciplinary Actions', Icons.warning, [
                    'Minor violations may result in warnings or detention.',
                    'Serious violations may lead to suspension or expulsion.',
                    'Parents will be informed of all disciplinary actions.',
                    'Students have the right to appeal disciplinary decisions.',
                    'Repeated violations will result in stricter penalties.',
                  ]),

                  const SizedBox(height: 24),

                  _buildRulesSection(
                    'Parental Responsibilities',
                    Icons.family_restroom,
                    [
                      'Ensure regular attendance of their children.',
                      'Monitor academic progress and homework completion.',
                      'Attend parent-teacher meetings regularly.',
                      'Support school policies and disciplinary measures.',
                      'Maintain open communication with teachers and staff.',
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Important Notice
                  Card(
                    color: Colors.amber[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Colors.amber[800],
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Important Notice',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'These rules and regulations are designed to maintain a safe, respectful, and productive learning environment. All students and parents are expected to read, understand, and follow these guidelines. The school reserves the right to modify these rules as necessary for the betterment of the school community.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.amber[800],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Contact Information
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'For Questions or Clarifications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildContactRow(
                            Icons.phone,
                            'Phone',
                            '+1 234 567 8900',
                          ),
                          const SizedBox(height: 8),
                          _buildContactRow(
                            Icons.email,
                            'Email',
                            'rules@sslaschool.edu',
                          ),
                          const SizedBox(height: 8),
                          _buildContactRow(
                            Icons.schedule,
                            'Office Hours',
                            'Monday - Friday: 8:00 AM - 4:00 PM',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRulesSection(String title, IconData icon, List<String> rules) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...rules.map(
              (rule) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(rule, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
