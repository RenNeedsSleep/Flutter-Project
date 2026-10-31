import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/booking_details.dart';
import '../providers/booking_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/app_background.dart';
import '../widgets/responsive_center.dart';
import '../widgets/step_header.dart';

class RequestFormScreen extends StatefulWidget {
  const RequestFormScreen({super.key});

  @override
  State<RequestFormScreen> createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();
  String _service = 'Cleaning';
  String _contactMethod = 'Call';
  bool _urgent = false;
  bool _agree = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>().provider;
    _service = provider?.category ?? _service;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: ResponsiveCenter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const StepHeader(
                        stepText: 'STEP 1',
                        title: 'Tell us what you need',
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Full name'),
                        validator: (value) {
                          if (value == null || value.trim().length < 3) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(labelText: 'Phone number'),
                        validator: (value) {
                          if (value == null || value.replaceAll(RegExp(r'\D'), '').length != 10) {
                            return 'Enter exactly 10 digits';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email (optional)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: 'Address'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Address is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _service,
                        decoration: const InputDecoration(labelText: 'Service type'),
                        items: ['Cleaning', 'Landscaping', 'Electrical', 'Plumbing']
                            .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _service = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text('Preferred contact', style: Theme.of(context).textTheme.bodyMedium),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Call'),
                              value: 'Call',
                              groupValue: _contactMethod,
                              onChanged: (value) => setState(() => _contactMethod = value ?? 'Call'),
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Message'),
                              value: 'Message',
                              groupValue: _contactMethod,
                              onChanged: (value) => setState(() => _contactMethod = value ?? 'Message'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Urgent request'),
                          const Spacer(),
                          Switch(
                            value: _urgent,
                            onChanged: (value) => setState(() => _urgent = value),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        maxLength: 200,
                        decoration: const InputDecoration(labelText: 'Notes'),
                      ),
                      const SizedBox(height: 16),
                      CheckboxListTile(
                        value: _agree,
                        onChanged: (value) => setState(() => _agree = value ?? false),
                        title: const Text('I agree to the terms and conditions'),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() && _agree) {
                              context.read<BookingProvider>().setDetails(
                                BookingDetails(
                                  name: _nameController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  email: _emailController.text.trim(),
                                  address: _addressController.text.trim(),
                                  service: _service,
                                  contactMethod: _contactMethod,
                                  urgent: _urgent,
                                  notes: _notesController.text.trim(),
                                ),
                              );
                              Navigator.pushNamed(context, AppRoutes.schedule);
                            } else if (!_agree) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please agree to the terms')),
                              );
                            }
                          },
                          child: const Text('Next'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
