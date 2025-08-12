import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text_form_field.dart';

class EmergencyContactWidget extends StatelessWidget {
  final TextEditingController emergencyContactNameController;
  final TextEditingController emergencyContactAddressController;
  final TextEditingController emergencyContactCityController;
  final TextEditingController emergencyContactPhoneController;
  final TextEditingController emergencyContactApartmentNoController;
  final TextEditingController emergencyContactZipCodeController;

  const EmergencyContactWidget({
    super.key,
    required this.emergencyContactNameController,
    required this.emergencyContactAddressController,
    required this.emergencyContactCityController,
    required this.emergencyContactPhoneController,
    required this.emergencyContactApartmentNoController,
    required this.emergencyContactZipCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.yellow[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.yellow[200]!),
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
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: const Text(
                  'Emergency Contact Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Single column layout for mobile optimization
          // Emergency Contact Name
          CustomTextFormField(
            name: 'emergencyContactName',
            controller: emergencyContactNameController,
            label: 'Emergency Contact Name',
            placeholder: 'Enter emergency contact name',
            icon: Icons.person,
            isRequired: true,
          ),
          const SizedBox(height: 16),

          // Emergency Contact Address
          CustomTextFormField(
            name: 'emergencyContactAddress',
            controller: emergencyContactAddressController,
            label: 'Emergency Contact Address',
            placeholder: 'Enter emergency contact address',
            icon: Icons.home,
            isRequired: true,
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          // Emergency Contact City
          CustomTextFormField(
            name: 'emergencyContactCity',
            controller: emergencyContactCityController,
            label: 'Emergency Contact City',
            placeholder: 'Enter emergency contact city',
            icon: Icons.location_city,
            isRequired: true,
          ),
          const SizedBox(height: 16),

          // Emergency Contact Phone
          CustomTextFormField(
            name: 'emergencyContactPhone',
            controller: emergencyContactPhoneController,
            label: 'Emergency Contact Phone',
            placeholder: 'Enter emergency contact phone',
            icon: Icons.phone,
            isRequired: true,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          // Emergency Contact Apartment Number
          CustomTextFormField(
            name: 'emergencyContactApartmentNo',
            controller: emergencyContactApartmentNoController,
            label: 'Emergency Contact Apartment Number',
            placeholder: 'Enter apartment number (optional)',
            icon: Icons.home,
          ),
          const SizedBox(height: 16),

          // Emergency Contact Zip Code
          CustomTextFormField(
            name: 'emergencyContactZipCode',
            controller: emergencyContactZipCodeController,
            label: 'Emergency Contact Zip Code',
            placeholder: 'Enter emergency contact zip code',
            icon: Icons.location_on,
            isRequired: true,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
