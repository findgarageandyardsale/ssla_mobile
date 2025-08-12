import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text_form_field.dart';

class FamilyInformationWidget extends StatelessWidget {
  final TextEditingController fatherNameController;
  final TextEditingController motherNameController;

  const FamilyInformationWidget({
    super.key,
    required this.fatherNameController,
    required this.motherNameController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.pink[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink[200]!),
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
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'Family Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Father's Name
          CustomTextFormField(
            name: 'fatherName',
            controller: this.fatherNameController,
            label: 'Father\'s Name',
            placeholder: 'Enter father\'s name',
            icon: Icons.person,
            isRequired: true,
          ),
          const SizedBox(height: 16),

          // Mother's Name
          CustomTextFormField(
            name: 'motherName',
            controller: this.motherNameController,
            label: 'Mother\'s Name',
            placeholder: 'Enter mother\'s name',
            icon: Icons.person,
            isRequired: true,
          ),
        ],
      ),
    );
  }
}
