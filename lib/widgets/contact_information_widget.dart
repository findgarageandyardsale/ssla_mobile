import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text_form_field.dart';

class ContactInformationWidget extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController apartmentNoController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;
  final TextEditingController homePhoneController;
  final TextEditingController cellPhoneController;
  final TextEditingController emailController;

  const ContactInformationWidget({
    super.key,
    required this.addressController,
    required this.apartmentNoController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
    required this.homePhoneController,
    required this.cellPhoneController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[200]!),
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
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Contact Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Address
          CustomTextFormField(
            name: 'address',
            controller: addressController,
            label: 'Address',
            placeholder: 'Enter your address',
            icon: Icons.home,
            isRequired: true,
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          // Apartment Number
          CustomTextFormField(
            name: 'apartmentNo',
            controller: apartmentNoController,
            label: 'Apartment Number',
            placeholder: 'Enter apartment number (optional)',
            icon: Icons.home,
          ),
          const SizedBox(height: 16),

          // City and State Row
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  name: 'city',
                  controller: cityController,
                  label: 'City',
                  placeholder: 'Enter city',
                  icon: Icons.location_city,
                  isRequired: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFormField(
                  name: 'state',
                  controller: stateController,
                  label: 'State',
                  placeholder: 'Enter state',
                  icon: Icons.location_city,
                  isRequired: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Zip Code
          CustomTextFormField(
            name: 'zipCode',
            controller: zipCodeController,
            label: 'Zip Code',
            placeholder: 'Enter zip code',
            icon: Icons.location_on,
            isRequired: true,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),

          // Phone Numbers Row
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  name: 'homePhone',
                  controller: homePhoneController,
                  label: 'Home Phone',
                  placeholder: 'Enter home phone',
                  icon: Icons.phone,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextFormField(
                  name: 'cellPhone',
                  controller: cellPhoneController,
                  label: 'Cell Phone',
                  placeholder: 'Enter cell phone',
                  icon: Icons.phone,
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Email
          CustomTextFormField(
            name: 'email',
            controller: emailController,
            label: 'Email',
            placeholder: 'Enter your email',
            icon: Icons.email,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
