import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers_provider.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/category_chip.dart';
import '../widgets/provider_card.dart';
import '../widgets/responsive_center.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> categories = [
    'All',
    'Cleaning',
    'Landscaping',
    'Electrical',
    'Plumbing',
  ];

  @override
  Widget build(BuildContext context) {
    final providersProvider = context.watch<ProvidersProvider>();
    final providers = providersProvider.filteredProviders;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: ResponsiveCenter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Hi! Find help',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search providers',
                      prefixIcon: const Icon(Icons.search, color: AppColors.muted),
                    ),
                    onChanged: providersProvider.setSearch,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 52,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final selected = providersProvider.selectedCategory == category;
                        return CategoryChip(
                          label: category,
                          selected: selected,
                          onTap: () => providersProvider.setCategory(category),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (providers.isEmpty)
                    _emptyState(context)
                  else
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final columns = constraints.maxWidth < 600
                            ? 1
                            : constraints.maxWidth < 1024
                                ? 2
                                : 3;

                        return GridView.builder(
                          itemCount: providers.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.3,
                          ),
                          itemBuilder: (context, index) {
                            final provider = providers[index];
                            return ProviderCard(
                              provider: provider,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.details,
                                  arguments: provider,
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded, size: 40, color: AppColors.muted),
          const SizedBox(height: 12),
          Text(
            'No providers found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
