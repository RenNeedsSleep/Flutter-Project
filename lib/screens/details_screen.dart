import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/service_provider.dart';
import '../providers/booking_provider.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../utils/category_icons.dart';
import '../widgets/app_background.dart';
import '../widgets/info_row.dart';
import '../widgets/responsive_center.dart';

class DetailsScreen extends StatelessWidget {
  final ServiceProvider provider;

  const DetailsScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 760;

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _photoPanel(context)),
                        const SizedBox(width: 20),
                        Expanded(child: _infoPanel(context)),
                      ],
                    )
                  : Column(
                      children: [
                        _photoPanel(context),
                        const SizedBox(height: 18),
                        _infoPanel(context),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _photoPanel(BuildContext context) {
    return Container(
      height: 420,
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD9EAFD), Color(0xFFBFE7D6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      provider.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (provider.verified) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.verified, color: Colors.white, size: 18),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  provider.city,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(
            label: 'Rating',
            icon: Icons.star,
            value: '${provider.rating} • ${provider.reviews} reviews',
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Category',
            icon: categoryIcon(provider.category),
            value: provider.category,
          ),
          const SizedBox(height: 18),
          InfoRow(
            label: 'Price',
            icon: Icons.currency_rupee,
            value: 'from ₹${provider.pricePerHour} / hour',
          ),
          const SizedBox(height: 24),
          Text('About', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(provider.about, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<BookingProvider>().setProvider(provider);
                Navigator.pushNamed(context, AppRoutes.request);
              },
              child: const Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }

}
