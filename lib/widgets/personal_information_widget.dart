import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text_form_field.dart';

class PersonalInformationWidget extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController ageController;
  final TextEditingController dateOfBirthController;
  final String? selectedGender;
  final String? selectedReturningStudent;
  final Function(String?) onGenderChanged;
  final Function(String?) onReturningStudentChanged;
  final VoidCallback onDateOfBirthTap;

  const PersonalInformationWidget({
    super.key,
    required this.firstNameController,
    required this.middleNameController,
    required this.lastNameController,
    required this.ageController,
    required this.dateOfBirthController,
    required this.selectedGender,
    required this.selectedReturningStudent,
    required this.onGenderChanged,
    required this.onReturningStudentChanged,
    required this.onDateOfBirthTap,
  });

  @override
  State<PersonalInformationWidget> createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> returningStudentOptions = ['Yes', 'No'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Single column layout
          Column(
            children: [
              // First Name
              CustomTextFormField(
                name: 'firstName',
                controller: widget.firstNameController,
                label: 'First Name',
                placeholder: 'Enter your first name',
                icon: Icons.person,
                isRequired: true,
              ),
              const SizedBox(height: 16),

              // Middle Name
              CustomTextFormField(
                name: 'middleName',
                controller: widget.middleNameController,
                label: 'Middle Name',
                placeholder: 'Enter your middle name',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),

              // Last Name
              CustomTextFormField(
                name: 'lastName',
                controller: widget.lastNameController,
                label: 'Last Name',
                placeholder: 'Enter your last name',
                icon: Icons.person,
                isRequired: true,
              ),
              const SizedBox(height: 16),

              // Age
              CustomTextFormField(
                name: 'age',
                controller: widget.ageController,
                label: 'Age',
                placeholder: 'Enter your age',
                icon: Icons.cake,
                isRequired: true,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Date of Birth
              CustomTextFormField(
                name: 'dateOfBirth',
                controller: widget.dateOfBirthController,
                label: 'Date of Birth',
                placeholder: 'dd/mm/yyyy',
                icon: Icons.calendar_today,
                isRequired: true,
                readOnly: true,
                onTap: widget.onDateOfBirthTap,
              ),
              const SizedBox(height: 16),

              // Gender
              _buildGenderDropdown(),
              const SizedBox(height: 16),

              // Returning Student
              _buildReturningStudentSection(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Gender',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: widget.selectedGender,
          decoration: InputDecoration(
            hintText: 'Select Gender',
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            // suffixIcon: const Icon(
            //   Icons.keyboard_arrow_down,
            //   color: Colors.grey,
            // ),
          ),
          items:
              genderOptions.map((gender) {
                return DropdownMenuItem(value: gender, child: Text(gender));
              }).toList(),
          onChanged: widget.onGenderChanged,
        ),
      ],
    );
  }

  Widget _buildReturningStudentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Returning Student',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const Text(
              ' *',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children:
              returningStudentOptions.map((option) {
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: widget.selectedReturningStudent,
                    onChanged: widget.onReturningStudentChanged,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
