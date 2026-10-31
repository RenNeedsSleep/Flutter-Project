import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class ResponsiveCenter extends StatelessWidget {
  final Widget child;

  const ResponsiveCenter({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final maxWidth = Responsive.isDesktop(context)
        ? 1100.0
        : Responsive.isTablet(context)
            ? 700.0
            : width;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
