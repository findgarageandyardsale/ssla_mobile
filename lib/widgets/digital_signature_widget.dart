import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../utils/app_colors.dart';
import 'custom_text_form_field.dart';
import 'date_input_field.dart';

class DigitalSignatureWidget extends StatefulWidget {
  final TextEditingController studentDateOfSignatureController;
  final TextEditingController parentDateOfSignatureController;
  final VoidCallback onStudentDateOfSignatureTap;
  final VoidCallback onParentDateOfSignatureTap;
  final Function(Uint8List?) onStudentSignatureChanged;
  final Function(Uint8List?) onParentSignatureChanged;

  const DigitalSignatureWidget({
    super.key,
    required this.studentDateOfSignatureController,
    required this.parentDateOfSignatureController,
    required this.onStudentDateOfSignatureTap,
    required this.onParentDateOfSignatureTap,
    required this.onStudentSignatureChanged,
    required this.onParentSignatureChanged,
  });

  @override
  State<DigitalSignatureWidget> createState() => _DigitalSignatureWidgetState();
}

class _DigitalSignatureWidgetState extends State<DigitalSignatureWidget> {
  final SignatureController _studentSignatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  final SignatureController _parentSignatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _studentSignatureController.dispose();
    _parentSignatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
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
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: const Text(
                  'Digital Signatures',
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

          // Student Signature Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Student Signature',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    const Text(
                      'Draw Your Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Signature Canvas and Date Row
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Signature(
                      controller: _studentSignatureController,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Student Signature Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        label: 'Clear',
                        icon: Icons.refresh,
                        color: Colors.grey[300]!,
                        textColor: Colors.grey[700]!,
                        onPressed: () {
                          _studentSignatureController.clear();
                          widget.onStudentSignatureChanged(null);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        label: 'Save',
                        icon: Icons.save,
                        color: Colors.green[300]!,
                        textColor: Colors.white,
                        onPressed: () {
                          _saveSignature(
                            _studentSignatureController,
                            widget.onStudentSignatureChanged,
                            'Student',
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: const Text(
                            'Date of Signature',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const Text(
                          ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Date Input Field
                    DateInputField(
                      name: 'studentDateOfSignature',
                      controller: widget.studentDateOfSignatureController,
                      onTap: widget.onStudentDateOfSignatureTap,
                      focusedBorderColor: Colors.blue,
                      enabledBorderColor: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

                const SizedBox(height: 16),

                const SizedBox(height: 12),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Parent/Guardian Signature Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Parent/Guardian Signature',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    const Text(
                      'Draw Parent/Guardian Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Signature Canvas and Date Row
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Signature(
                      controller: _parentSignatureController,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Parent Signature Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        label: 'Clear',
                        icon: Icons.refresh,
                        color: Colors.grey[300]!,
                        textColor: Colors.grey[700]!,
                        onPressed: () {
                          _parentSignatureController.clear();
                          widget.onParentSignatureChanged(null);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        label: 'Save',
                        icon: Icons.save,
                        color: Colors.green[300]!,
                        textColor: Colors.white,
                        onPressed: () {
                          _saveSignature(
                            _parentSignatureController,
                            widget.onParentSignatureChanged,
                            'Parent',
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date of Parent/Guardian Signature',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const Text(
                      ' *',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Date Input Field
                    DateInputField(
                      name: 'parentDateOfSignature',
                      controller: widget.parentDateOfSignatureController,
                      onTap: widget.onParentDateOfSignatureTap,
                      focusedBorderColor: Colors.green,
                      enabledBorderColor: Colors.green[300],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    double? width,
  }) {
    return SizedBox(
      height: 40,
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18, color: textColor),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildInstructionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _saveSignature(
    SignatureController controller,
    Function(Uint8List?) onSignatureChanged,
    String signatureType,
  ) async {
    if (controller.isNotEmpty) {
      final signature = await controller.toPngBytes();
      onSignatureChanged(signature);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$signatureType signature saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please draw a $signatureType signature first'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _downloadSignature(
    SignatureController controller,
    String signatureType,
  ) async {
    if (controller.isNotEmpty) {
      final signature = await controller.toPngBytes();
      // Here you would implement the actual download functionality
      // For now, just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$signatureType signature download initiated!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please draw a $signatureType signature first'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  void _uploadSignature(
    SignatureController controller,
    String signatureType,
  ) async {
    if (controller.isNotEmpty) {
      final signature = await controller.toPngBytes();
      // Here you would implement the actual upload functionality
      // For now, just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$signatureType signature uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please draw a $signatureType signature first'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }
}
