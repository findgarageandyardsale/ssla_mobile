import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/courses_provider.dart';
import '../models/course.dart';
import '../utils/app_colors.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _previousSchoolController = TextEditingController();

  Course? selectedCourse;
  String selectedGrade = 'Grade 1';
  DateTime? selectedDateOfBirth;

  final List<String> grades = [
    'Grade 1',
    'Grade 2',
    'Grade 3',
    'Grade 4',
    'Grade 5',
    'Grade 6',
    'Grade 7',
    'Grade 8',
    'Grade 9',
    'Grade 10',
    'Grade 11',
    'Grade 12',
  ];

  @override
  void dispose() {
    _studentNameController.dispose();
    _parentNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dateOfBirthController.dispose();
    _previousSchoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Student Registration')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(coursesProvider);
        },
        child: SingleChildScrollView(
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
                    Icon(Icons.app_registration, size: 50, color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Student Registration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Registration Form
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Registration Form',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Student Information Section
                      const Text(
                        'Student Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _studentNameController,
                        decoration: const InputDecoration(
                          labelText: 'Student Full Name *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter student name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _dateOfBirthController,
                              decoration: const InputDecoration(
                                labelText: 'Date of Birth *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              readOnly: true,
                              onTap: () => _selectDateOfBirth(context),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select date of birth';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: selectedGrade,
                              decoration: const InputDecoration(
                                labelText: 'Grade Level *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.grade),
                              ),
                              items:
                                  grades.map((grade) {
                                    return DropdownMenuItem(
                                      value: grade,
                                      child: Text(grade),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedGrade = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select grade level';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _previousSchoolController,
                        decoration: const InputDecoration(
                          labelText: 'Previous School (if any)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.school),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Course Selection Section
                      const Text(
                        'Course Selection',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                      const SizedBox(height: 16),

                      coursesAsync.when(
                        data:
                            (courses) => DropdownButtonFormField<Course>(
                              value: selectedCourse,
                              decoration: const InputDecoration(
                                labelText: 'Select Course *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.book),
                              ),
                              items:
                                  courses.map((course) {
                                    return DropdownMenuItem(
                                      value: course,
                                      child: Text(
                                        '${course.name} - ${course.level}',
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCourse = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a course';
                                }
                                return null;
                              },
                            ),
                        loading:
                            () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        error:
                            (error, stack) =>
                                const Text('Error loading courses'),
                      ),
                      const SizedBox(height: 24),

                      // Parent/Guardian Information Section
                      const Text(
                        'Parent/Guardian Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1976D2),
                        ),
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _parentNameController,
                        decoration: const InputDecoration(
                          labelText: 'Parent/Guardian Name *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.family_restroom),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter parent/guardian name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email Address *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email address';
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Phone Number *',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Course Details (if selected)
                      if (selectedCourse != null) ...[
                        Card(
                          color: Colors.blue[50],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selected Course Details',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildCourseDetail(
                                  'Course',
                                  selectedCourse!.name,
                                ),
                                _buildCourseDetail(
                                  'Level',
                                  selectedCourse!.level,
                                ),
                                _buildCourseDetail(
                                  'Duration',
                                  selectedCourse!.duration,
                                ),
                                _buildCourseDetail(
                                  'Fee',
                                  '\$${selectedCourse!.fee.toStringAsFixed(0)}',
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _submitRegistration,
                          icon: const Icon(Icons.send),
                          label: const Text('Submit Registration'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 5),
      ), // 5 years ago
      firstDate: DateTime.now().subtract(
        const Duration(days: 365 * 25),
      ), // 25 years ago
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDateOfBirth = picked;
        _dateOfBirthController.text =
            '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      // Show success dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Registration Submitted!'),
              content: const Text(
                'Thank you for your registration. We will review your application and contact you soon with further details.',
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _clearForm();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  void _clearForm() {
    _studentNameController.clear();
    _parentNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _dateOfBirthController.clear();
    _previousSchoolController.clear();
    setState(() {
      selectedCourse = null;
      selectedGrade = 'Grade 1';
      selectedDateOfBirth = null;
    });
  }
}
