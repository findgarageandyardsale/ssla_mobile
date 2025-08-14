import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../services/supabase_service.dart';
import '../services/email_service.dart';
import '../widgets/courses_selection_widget.dart';
import '../widgets/personal_information_widget.dart';
import '../widgets/family_information_widget.dart';
import '../widgets/contact_information_widget.dart';
import '../widgets/emergency_contact_widget.dart';
import '../widgets/extra_information_widget.dart';
import '../widgets/digital_signature_widget.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormBuilderState>();
  final _studentNameController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _previousSchoolController = TextEditingController();

  // Personal Information Controllers
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  // Family Information Controllers
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();

  // Contact Information Controllers
  final _apartmentNoController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _homePhoneController = TextEditingController();
  final _cellPhoneController = TextEditingController();

  // Emergency Contact Controllers
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactAddressController = TextEditingController();
  final _emergencyContactCityController = TextEditingController();
  final _emergencyContactPhoneController = TextEditingController();
  final _emergencyContactApartmentNoController = TextEditingController();
  final _emergencyContactZipCodeController = TextEditingController();

  // Extra Information Controllers
  final _whatInspiresController = TextEditingController();
  final _favoriteSikhBookController = TextEditingController();

  // Completed Courses Controller (for returning students)
  final _completedCoursesController = TextEditingController();

  // Digital Signature Controllers
  final _studentDateOfSignatureController = TextEditingController();
  final _parentDateOfSignatureController = TextEditingController();

  List<String> selectedCourseIds = [];
  DateTime? selectedDateOfBirth;
  String? selectedGender;
  String? selectedReturningStudent;

  // Extra Information Variables
  String? selectedSpeakPunjabi;
  String? selectedReadWritePunjabi;
  String? selectedHomeworkTime;

  // Digital Signature Variables
  Uint8List? studentSignature;
  Uint8List? parentSignature;

  // Signature URLs from Supabase storage
  String? studentSignatureUrl;
  String? parentSignatureUrl;
  final List<String> courses = [
    'Punjabi Language',

    'Gurmat',

    'Gurbani Santhya',

    'Keertan',

    'Gurmat (age 18+)',
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

    // Dispose personal information controllers
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();

    // Dispose family information controllers
    _fatherNameController.dispose();
    _motherNameController.dispose();

    // Dispose contact information controllers
    _apartmentNoController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _homePhoneController.dispose();
    _cellPhoneController.dispose();

    // Dispose emergency contact controllers
    _emergencyContactNameController.dispose();
    _emergencyContactAddressController.dispose();
    _emergencyContactCityController.dispose();
    _emergencyContactPhoneController.dispose();
    _emergencyContactApartmentNoController.dispose();
    _emergencyContactZipCodeController.dispose();

    // Dispose extra information controllers
    _whatInspiresController.dispose();
    _favoriteSikhBookController.dispose();
    _completedCoursesController.dispose();

    // Dispose digital signature controllers
    _studentDateOfSignatureController.dispose();
    _parentDateOfSignatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Registration')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Icon(Icons.school_outlined, size: 50),

                  Text(
                    'Registration Form',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    '''Welcome to our school! Please fill out the form below to complete your registration. We're excited to have you join our community''',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            // Registration Form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Select Courses
                    CoursesSelectionWidget(
                      courses: courses,
                      selectedCourseIds: selectedCourseIds,
                      onCoursesChanged: (courseIds) {
                        setState(() {
                          selectedCourseIds = courseIds;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Personal Information Section
                    PersonalInformationWidget(
                      firstNameController: _firstNameController,
                      middleNameController: _middleNameController,
                      lastNameController: _lastNameController,
                      ageController: _ageController,
                      dateOfBirthController: _dateOfBirthController,
                      selectedGender: selectedGender,
                      selectedReturningStudent: selectedReturningStudent,
                      onGenderChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      onReturningStudentChanged: (value) {
                        setState(() {
                          selectedReturningStudent = value;
                        });
                      },
                      onDateOfBirthTap: () => _selectDateOfBirth(context),
                    ),
                    if (selectedReturningStudent != 'Yes') ...[
                      const SizedBox(height: 16),
                    ],

                    // Completed Courses Section (for returning students)
                    if (selectedReturningStudent == 'Yes') ...[
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _completedCoursesController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'List courses completed at SSLA *',
                          hintText:
                              'Please list all courses you have previously completed at SSLA...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please list your completed courses';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),
                    ],

                    // Family Information Section
                    FamilyInformationWidget(
                      fatherNameController: _fatherNameController,
                      motherNameController: _motherNameController,
                    ),
                    const SizedBox(height: 24),

                    // Contact Information Section
                    ContactInformationWidget(
                      addressController: _addressController,
                      apartmentNoController: _apartmentNoController,
                      cityController: _cityController,
                      stateController: _stateController,
                      zipCodeController: _zipCodeController,
                      homePhoneController: _homePhoneController,
                      cellPhoneController: _cellPhoneController,
                      emailController: _emailController,
                    ),
                    const SizedBox(height: 24),

                    // Emergency Contact Information Section
                    EmergencyContactWidget(
                      emergencyContactNameController:
                          _emergencyContactNameController,
                      emergencyContactAddressController:
                          _emergencyContactAddressController,
                      emergencyContactCityController:
                          _emergencyContactCityController,
                      emergencyContactPhoneController:
                          _emergencyContactPhoneController,
                      emergencyContactApartmentNoController:
                          _emergencyContactApartmentNoController,
                      emergencyContactZipCodeController:
                          _emergencyContactZipCodeController,
                    ),
                    const SizedBox(height: 24),

                    // Extra Information Section
                    ExtraInformationWidget(
                      selectedSpeakPunjabi: selectedSpeakPunjabi,
                      selectedReadWritePunjabi: selectedReadWritePunjabi,
                      selectedHomeworkTime: selectedHomeworkTime,
                      whatInspiresController: _whatInspiresController,
                      favoriteSikhBookController: _favoriteSikhBookController,
                      onSpeakPunjabiChanged: (value) {
                        setState(() {
                          selectedSpeakPunjabi = value;
                        });
                      },
                      onReadWritePunjabiChanged: (value) {
                        setState(() {
                          selectedReadWritePunjabi = value;
                        });
                      },
                      onHomeworkTimeChanged: (value) {
                        setState(() {
                          selectedHomeworkTime = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Digital Signature Section
                    DigitalSignatureWidget(
                      studentDateOfSignatureController:
                          _studentDateOfSignatureController,
                      parentDateOfSignatureController:
                          _parentDateOfSignatureController,
                      onStudentDateOfSignatureTap:
                          () => _selectDateOfSignature(context),
                      onParentDateOfSignatureTap:
                          () => _selectParentDateOfSignature(context),
                      onStudentSignatureChanged: (signature) async {
                        setState(() {
                          studentSignature = signature;
                        });

                        // Upload signature to Supabase if signature data exists
                        if (signature != null) {
                          final studentName =
                              _firstNameController.text.isNotEmpty
                                  ? '${_firstNameController.text}_${_lastNameController.text}'
                                  : 'student';
                          final fileName = _generateSignatureFileName(
                            'student',
                            studentName,
                          );

                          final url = await _uploadSignatureToSupabase(
                            signature,
                            fileName,
                          );
                          if (url != null) {
                            setState(() {
                              studentSignatureUrl = url;
                            });
                          }
                        }
                      },
                      onParentSignatureChanged: (signature) async {
                        setState(() {
                          parentSignature = signature;
                        });

                        // Upload signature to Supabase if signature data exists
                        if (signature != null) {
                          final studentName =
                              _firstNameController.text.isNotEmpty
                                  ? '${_firstNameController.text}_${_lastNameController.text}'
                                  : 'student';
                          final fileName = _generateSignatureFileName(
                            'parent',
                            studentName,
                          );

                          final url = await _uploadSignatureToSupabase(
                            signature,
                            fileName,
                          );
                          if (url != null) {
                            setState(() {
                              parentSignatureUrl = url;
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 24),

                    // Course Details (if selected)
                    if (selectedCourseIds.isNotEmpty) ...[
                      Card(
                        color: Colors.blue[50],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Courses (${selectedCourseIds.length})',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...selectedCourseIds.map((courseName) {
                                return _buildCourseDetail('Course', courseName);
                              }).toList(),
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

  Future<void> _selectDateOfSignature(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _studentDateOfSignatureController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  Future<void> _selectParentDateOfSignature(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _parentDateOfSignatureController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  void _submitRegistration() {
    // Check if completed courses are required for returning students
    bool isCompletedCoursesValid = true;
    if (selectedReturningStudent == 'Yes') {
      isCompletedCoursesValid =
          _completedCoursesController.text.trim().isNotEmpty;
    }

    if (_formKey.currentState!.validate() &&
        selectedCourseIds.isNotEmpty &&
        studentSignature != null &&
        parentSignature != null &&
        isCompletedCoursesValid) {
      // Send registration email via EmailJS
      _sendRegistrationEmail();
    } else if (selectedCourseIds.isEmpty) {
      // Show error for no courses selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one course'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (studentSignature == null || parentSignature == null) {
      // Show error for missing signatures
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please provide both student and parent/guardian signatures',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!isCompletedCoursesValid) {
      // Show error for missing completed courses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please list your completed courses at SSLA'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Show error for form validation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields correctly'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Send registration email via EmailJS
  Future<void> _sendRegistrationEmail() async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => const AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 16),
                  Text('Sending registration...'),
                ],
              ),
            ),
      );

      // Prepare data for email
      final personalInfo = {
        'firstName': _firstNameController.text,
        'middleName': _middleNameController.text,
        'lastName': _lastNameController.text,
        'age': _ageController.text,
        'gender': selectedGender ?? '',
        'dateOfBirth': _dateOfBirthController.text,
        'studentSignatureDate': _studentDateOfSignatureController.text,
        'parentSignatureDate': _parentDateOfSignatureController.text,
      };

      final familyInfo = {
        'fatherName': _fatherNameController.text,
        'motherName': _motherNameController.text,
      };

      final contactInfo = {
        'address': _addressController.text,
        'apartmentNo': _apartmentNoController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'zipCode': _zipCodeController.text,
        'homePhone': _homePhoneController.text,
        'cellPhone': _cellPhoneController.text,
      };

      final emergencyInfo = {
        'name': _emergencyContactNameController.text,
        'phone': _emergencyContactPhoneController.text,
        'address': _emergencyContactAddressController.text,
        'apartmentNo': _emergencyContactApartmentNoController.text,
        'city': _emergencyContactCityController.text,
        'zipCode': _emergencyContactZipCodeController.text,
      };

      final extraInfo = {
        'speakPunjabi': selectedSpeakPunjabi ?? '',
        'readWritePunjabi': selectedReadWritePunjabi ?? '',
        'whatInspires': _whatInspiresController.text,
        'favoriteBook': _favoriteSikhBookController.text,
        'homeworkTime': selectedHomeworkTime ?? '',
      };

      final studentName =
          '${_firstNameController.text} ${_lastNameController.text}'.trim();
      final email = _emailController.text;
      final phone = _phoneController.text;

      // Send email
      final emailService = EmailService();
      await emailService.sendRegistrationEmail(
        studentName: studentName,
        parentName: 'Parent/Guardian',
        email: email,
        phone: phone,
        selectedCourses: selectedCourseIds,
        completedCourses:
            selectedReturningStudent == 'Yes'
                ? _completedCoursesController.text
                : null,
        studentSignatureUrl: studentSignatureUrl,
        parentSignatureUrl: parentSignatureUrl,
        personalInfo: personalInfo,
        familyInfo: familyInfo,
        contactInfo: contactInfo,
        emergencyInfo: emergencyInfo,
        extraInfo: extraInfo,
      );

      // Close loading dialog
      Navigator.of(context).pop();

      // Show success dialog
      _showSuccessDialog();
    } catch (error) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send registration: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Registration Submitted!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thank you for your registration. We will review your application and contact you soon with further details.',
                ),
                if (studentSignatureUrl != null) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Student Signature URL:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    studentSignatureUrl!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
                if (parentSignatureUrl != null) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Parent Signature URL:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    parentSignatureUrl!,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ],
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

  void _clearForm() {
    _studentNameController.clear();
    _parentNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _addressController.clear();
    _dateOfBirthController.clear();
    _previousSchoolController.clear();

    // Clear personal information controllers
    _firstNameController.clear();
    _middleNameController.clear();
    _lastNameController.clear();
    _ageController.clear();

    // Clear family information controllers
    _fatherNameController.clear();
    _motherNameController.clear();

    // Clear contact information controllers
    _apartmentNoController.clear();
    _cityController.clear();
    _stateController.clear();
    _zipCodeController.clear();
    _homePhoneController.clear();
    _cellPhoneController.clear();

    // Clear emergency contact controllers
    _emergencyContactNameController.clear();
    _emergencyContactAddressController.clear();
    _emergencyContactCityController.clear();
    _emergencyContactPhoneController.clear();
    _emergencyContactApartmentNoController.clear();
    _emergencyContactZipCodeController.clear();

    // Clear extra information controllers
    _whatInspiresController.clear();
    _favoriteSikhBookController.clear();
    _completedCoursesController.clear();

    // Clear digital signature controllers
    _studentDateOfSignatureController.clear();
    _parentDateOfSignatureController.clear();

    setState(() {
      selectedCourseIds.clear();
      selectedDateOfBirth = null;
      selectedGender = null;
      selectedReturningStudent = null;
      selectedSpeakPunjabi = null;
      selectedReadWritePunjabi = null;
      selectedHomeworkTime = null;
      studentSignature = null;
      parentSignature = null;
      studentSignatureUrl = null;
      parentSignatureUrl = null;
    });
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

  /// Upload signature to Supabase storage and return the URL
  Future<String?> _uploadSignatureToSupabase(
    Uint8List signatureData,
    String fileName,
  ) async {
    try {
      // Get the signatures bucket
      final bucket = SupabaseService.client.storage.from('signatures');

      // Upload the signature data
      await bucket.uploadBinary(fileName, signatureData);

      // Get the public URL
      final url = bucket.getPublicUrl(fileName);

      print('Signature uploaded successfully: $url');
      return url;
    } catch (e) {
      print('Error uploading signature: $e');
      return null;
    }
  }

  /// Generate unique filename for signature
  String _generateSignatureFileName(String type, String studentName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final sanitizedName = studentName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    return '${type}_${sanitizedName}_$timestamp.png';
  }
}
