import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/school_provider.dart';
import '../services/email_service.dart';
import '../utils/app_colors.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final schoolInfoAsync = ref.watch(schoolProvider);
    final emailSendingState = ref.watch(emailSendingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(schoolProvider);
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Information
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: schoolInfoAsync.when(
                  data:
                      (schoolInfo) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Contact Information',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  _buildContactItem(
                                    Icons.location_on,
                                    'Address',
                                    schoolInfo.address,
                                    Colors.red,
                                  ),
                                  const Divider(),
                                  _buildContactItem(
                                    Icons.phone,
                                    'Phone',
                                    schoolInfo.phone,
                                    Colors.green,
                                  ),
                                  const Divider(),
                                  _buildContactItem(
                                    Icons.email,
                                    'Email',
                                    schoolInfo.email,
                                    Colors.blue,
                                  ),
                                  const Divider(),
                                  _buildContactItem(
                                    Icons.language,
                                    'Website',
                                    schoolInfo.website,
                                    Colors.purple,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stack) =>
                          const Text('Error loading contact info'),
                ),
              ),

              // Contact Form
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Send us a Message',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Full Name',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _messageController,
                                decoration: const InputDecoration(
                                  labelText: 'Message',
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.message),
                                  alignLabelWithHint: true,
                                ),
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your message';
                                  }
                                  if (value.length < 10) {
                                    return 'Message must be at least 10 characters long';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed:
                                      emailSendingState.isLoading
                                          ? null
                                          : _submitForm,
                                  icon:
                                      emailSendingState.isLoading
                                          ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                          : const Icon(Icons.send),
                                  label: Text(
                                    emailSendingState.isLoading
                                        ? 'Sending...'
                                        : 'Send Message',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /*
              // Map Section (Placeholder)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Interactive Map Coming Soon',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          */
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder:
              (context) => const AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 16),
                    Text('Sending message...'),
                  ],
                ),
              ),
        );

        // Send email using the email service
        await ref
            .read(emailSendingProvider.notifier)
            .sendEmail(
              name: _nameController.text,
              email: _emailController.text,
              message: _messageController.text,
            );

        // Close loading dialog
        Navigator.of(context).pop();

        // Show success dialog
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Message Sent!'),
                content: const Text(
                  'Thank you for your message. We will get back to you soon!',
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _clearForm();
                      ref.read(emailSendingProvider.notifier).reset();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      } catch (error) {
        // Close loading dialog
        Navigator.of(context).pop();

        // Show error dialog
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Error'),
                content: Text('Failed to send message: $error'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ref.read(emailSendingProvider.notifier).reset();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    }
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _messageController.clear();
  }
}
