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
            // Rules Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRulesSection(
                    title: '📚 Homework And Home Study',
                    imageUrl: 'assets/rule/study.png',
                    rules: [
                      'Plan a daily homework time',
                      'Take home everything you will need',
                      'Don\'t study with the TV on',
                      'Read and follow all directions',
                      'Do your work neatly and carefully',
                      'Ask for help if you need it, but do the work yourself',
                      'Keep the top of your desk uncluttered',
                      'Keep your homework in a special place',
                      'Get into a routine by studying at the same time every day',
                      'Return homework on time',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildRulesSection(
                    title: '📚 To and From School',
                    imageUrl: 'assets/rule/to_from.png',
                    rules: [
                      'Classes begin at 9:30 a.m. The students must arrive between 9:15 to 9:25 a.m.',
                      'Students are not allowed to leave the classroom without permission anytime.',
                      'Students are dismissed at 12:50 p.m. Parents of students under age 6 must check with the teacher place of student dismissal.',
                      'Absences and tardies must be verified by a note. Three absences or tardies without a note may result in suspension.',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildRulesSection(
                    title: '📚 General Rules',
                    imageUrl: 'assets/rule/general_rules.jpg',
                    rules: [
                      'Vulgar or profane language is prohibited and may result in a suspension.',
                      'No toys, ipods, or electronic games are allowed while you are in the school.',
                      'No climbing on or over any fence.',
                      'Students are to keep classroom, bathroom, and Gurdwara premises neat and clean.',
                      'Students must wear school uniform.',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildRulesSection(
                    title: '📚 Discipline Policies',
                    imageUrl: 'assets/rule/discipline_policies.png',
                    rules: [
                      'Verbal warning',
                      'Parent notification or conferences',
                      'Suspension',
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildRulesSection(
                    title: '📚 Classroom Rules',
                    imageUrl: 'assets/rule/classroom_rules.png',
                    rules: [
                      'Listen carefully.',
                      'Follow directions.',
                      'Work quietly. Do not disturb others who are working.',
                      'Respect others. Be kind with your words and actions.',
                      'Respect school and personal property.',
                      'Be quiet all times. Raise your hand if need to speak.',
                    ],
                  ),

                  const SizedBox(height: 24),

                  const SizedBox(height: 32),

                  /*   // Important Notice
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
              */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRulesSection({
    required String title,
    required List<String> rules,
    String? imageUrl,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Image.asset(imageUrl, width: double.infinity, height: 150),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
