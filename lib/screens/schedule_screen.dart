import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/booking_provider.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/responsive_center.dart';
import '../widgets/time_slot_chip.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;

  final List<String> _morningSlots = ['9:00 AM', '9:30 AM', '10:00 AM', '10:30 AM'];
  final List<String> _afternoonSlots = ['1:00 PM', '1:30 PM', '2:00 PM', '2:30 PM'];

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    final canContinue = _selectedTime != null;

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
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('STEP 2', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primary)),
                    const SizedBox(height: 8),
                    Text('Choose Date & Time Slot', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: CalendarDatePicker(
                        initialDate: _selectedDate,
                        firstDate: DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        currentDate: DateTime.now(),
                        onDateChanged: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Morning', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _morningSlots.map((slot) {
                        final selected = _selectedTime == slot;
                        return TimeSlotChip(
                          label: slot,
                          selected: selected,
                          onTap: () => setState(() => _selectedTime = slot),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text('Afternoon', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: _afternoonSlots.map((slot) {
                        final selected = _selectedTime == slot;
                        return TimeSlotChip(
                          label: slot,
                          selected: selected,
                          onTap: () => setState(() => _selectedTime = slot),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: canContinue
                            ? () {
                                booking.setSchedule(_selectedDate, _selectedTime!);
                                Navigator.pushNamed(context, AppRoutes.review);
                              }
                            : null,
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
