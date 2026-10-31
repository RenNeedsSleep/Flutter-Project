import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/app_background.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) {
        setState(() {
          _showContent = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isWide = media.size.width >= 760;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedOpacity(
              opacity: _showContent ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _welcomeText(context),
                        ),
                        const SizedBox(width: 24),
                        SizedBox(
                          width: 320,
                          child: _quoteCard(context),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _welcomeText(context),
                        const SizedBox(height: 20),
                        _quoteCard(context),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _welcomeText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.handyman_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              'Aoxa',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(84, 40),
                side: const BorderSide(color: AppColors.primary),
                foregroundColor: AppColors.primary,
              ),
              child: const Text('Skip'),
            ),
          ],
        ),
        const SizedBox(height: 36),
        Text(
          'Find trusted help, nearby',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 12),
        Text(
          'Browse local pros, pick a time, and book in minutes.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 220,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: const Text('Get Started →'),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Takes less than a minute',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _quoteCard(BuildContext context) {
    return AnimatedSlide(
      offset: _showContent ? Offset.zero : const Offset(0, 0.25),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(17, 24, 39, 0.06),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFFB8E7E7), Color(0xFF7ED0C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 52,
                  backgroundColor: Color(0xFFD6F1EE),
                  child: Icon(Icons.person, size: 56, color: AppColors.ink),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, size: 16, color: AppColors.primary),
                  SizedBox(width: 6),
                  Text('Verified Provider'),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              '"I grew my business 3x after joining Aoxa!"',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            const Text('Asha, Electrician', style: TextStyle(color: AppColors.muted)),
          ],
        ),
      ),
    );
  }
}
