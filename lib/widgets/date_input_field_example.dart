import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'date_input_field.dart';

/// Example usage of the DateInputField component
/// This file demonstrates different ways to use the DateInputField
class DateInputFieldExample extends StatefulWidget {
  const DateInputFieldExample({super.key});

  @override
  State<DateInputFieldExample> createState() => _DateInputFieldExampleState();
}

class _DateInputFieldExampleState extends State<DateInputFieldExample> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _onDateTap() {
    // Show date picker
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          _dateController.text = '${date.day}/${date.month}/${date.year}';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DateInputField Examples')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Date Input Field Examples',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Basic usage
              const Text(
                'Basic Date Input:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DateInputField(
                name: 'basicDate',
                controller: _dateController,
                onTap: _onDateTap,
              ),
              const SizedBox(height: 24),

              // With custom styling
              const Text(
                'Custom Styled Date Input:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DateInputField(
                name: 'customDate',
                label: 'Select Date',
                hintText: 'Choose a date',
                controller: _dateController,
                onTap: _onDateTap,
                focusedBorderColor: Colors.purple,
                enabledBorderColor: Colors.purple[300],
                fillColor: Colors.purple[50],
                borderRadius: 12,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              const SizedBox(height: 24),

              // With validation
              const Text(
                'Required Date Input (with validation):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DateInputField(
                name: 'requiredDate',
                label: 'Required Date',
                controller: _dateController,
                onTap: _onDateTap,
                isRequired: true,
                focusedBorderColor: Colors.red,
                enabledBorderColor: Colors.red[300],
              ),
              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState!.value;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Form data: $formData')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit Form'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
