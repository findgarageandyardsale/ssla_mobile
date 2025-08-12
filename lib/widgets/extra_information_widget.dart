import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text_form_field.dart';

class ExtraInformationWidget extends StatefulWidget {
  final String? selectedSpeakPunjabi;
  final String? selectedReadWritePunjabi;
  final String? selectedHomeworkTime;
  final TextEditingController whatInspiresController;
  final TextEditingController favoriteSikhBookController;
  final Function(String?) onSpeakPunjabiChanged;
  final Function(String?) onReadWritePunjabiChanged;
  final Function(String?) onHomeworkTimeChanged;

  const ExtraInformationWidget({
    super.key,
    required this.selectedSpeakPunjabi,
    required this.selectedReadWritePunjabi,
    required this.selectedHomeworkTime,
    required this.whatInspiresController,
    required this.favoriteSikhBookController,
    required this.onSpeakPunjabiChanged,
    required this.onReadWritePunjabiChanged,
    required this.onHomeworkTimeChanged,
  });

  @override
  State<ExtraInformationWidget> createState() => _ExtraInformationWidgetState();
}

class _ExtraInformationWidgetState extends State<ExtraInformationWidget> {
  final List<String> punjabiOptions = ['Yes', 'No', 'Somewhat'];
  final List<String> homeworkTimeOptions = [
    '15 minutes',
    '20 minutes',
    '25 minutes',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple[200]!),
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
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: const Text(
                  'Extra Information',
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
          // Do you speak Punjabi?
          _buildRadioQuestion(
            question: 'Do you speak Punjabi?',
            options: punjabiOptions,
            selectedValue: widget.selectedSpeakPunjabi,
            onChanged: widget.onSpeakPunjabiChanged,
            isRequired: true,
          ),
          const SizedBox(height: 24),

          // Can you read and write Punjabi?
          _buildRadioQuestion(
            question: 'Can you read and write Punjabi?',
            options: punjabiOptions,
            selectedValue: widget.selectedReadWritePunjabi,
            onChanged: widget.onReadWritePunjabiChanged,
            isRequired: true,
          ),
          const SizedBox(height: 24),

          // What Inspires You
          CustomTextFormField(
            name: 'whatInspires',
            controller: widget.whatInspiresController,
            label: 'What Inspires You to Learn?',
            placeholder: 'Tell us what inspires you to learn',
            icon: Icons.lightbulb,
            isRequired: true,
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          // Favorite Sikh Book
          CustomTextFormField(
            name: 'favoriteSikhBook',
            controller: widget.favoriteSikhBookController,
            label: 'Favorite Sikh Book',
            placeholder: 'Enter your favorite Sikh book',
            icon: Icons.book,
            isRequired: true,
          ),
          const SizedBox(height: 24),

          // How much time you will have everyday to do your homework?
          _buildRadioQuestion(
            question:
                'How much time you will have everyday to do your homework?',
            options: homeworkTimeOptions,
            selectedValue: widget.selectedHomeworkTime,
            onChanged: widget.onHomeworkTimeChanged,
            isRequired: true,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioQuestion({
    required String question,
    required List<String> options,
    required String? selectedValue,
    required Function(String?) onChanged,
    required bool isRequired,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            if (isRequired)
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
        ...options.map((option) {
          return RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: selectedValue,
            onChanged: onChanged,
            contentPadding: EdgeInsets.zero,
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
          );
        }).toList(),
      ],
    );
  }
}
