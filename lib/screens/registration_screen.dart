import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../providers/courses_provider.dart';
import '../models/course.dart';
import '../utils/app_colors.dart';
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

  // Digital Signature Controllers
  final _studentDateOfSignatureController = TextEditingController();
  final _parentDateOfSignatureController = TextEditingController();

  List<String> selectedCourseIds = [];
  String selectedGrade = 'Grade 1';
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
                    const SizedBox(height: 24),

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
                      onStudentSignatureChanged: (signature) {
                        setState(() {
                          studentSignature = signature;
                        });
                      },
                      onParentSignatureChanged: (signature) {
                        setState(() {
                          parentSignature = signature;
                        });
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
    if (_formKey.currentState!.validate() &&
        selectedCourseIds.isNotEmpty &&
        studentSignature != null &&
        parentSignature != null) {
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

    // Clear digital signature controllers
    _studentDateOfSignatureController.clear();
    _parentDateOfSignatureController.clear();

    setState(() {
      selectedCourseIds.clear();
      selectedGrade = 'Grade 1';
      selectedDateOfBirth = null;
      selectedGender = null;
      selectedReturningStudent = null;
      selectedSpeakPunjabi = null;
      selectedReadWritePunjabi = null;
      selectedHomeworkTime = null;
      studentSignature = null;
      parentSignature = null;
    });
  }
}
