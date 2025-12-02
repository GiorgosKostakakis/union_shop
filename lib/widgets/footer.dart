import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 700;

    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: isNarrow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOpeningHours(),
                const SizedBox(height: 24),
                _buildHelpInfo(context),
                const SizedBox(height: 24),
                _buildLatestOffers(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 48),
                Expanded(child: _buildOpeningHours()),
                const SizedBox(width: 24),
                Expanded(child: _buildHelpInfo(context)),
                const SizedBox(width: 24),
                Expanded(child: _buildLatestOffers()),
                const SizedBox(width: 48),
              ],
            ),
    );
  }

  Widget _buildOpeningHours() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opening Hours',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '(Term Time)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Monday - Friday 9am - 4pm',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '(Outside of Term Time / Consolidation Weeks)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Monday - Friday 9am - 3pm',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Purchase online 24/7',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _buildHelpInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help & Info',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.go('/search'),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Search',
            style: TextStyle(
              color: Color(0xFF4d2963),
              fontSize: 14,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Information and Policy',
            style: TextStyle(
              color: Color(0xFF4d2963),
              fontSize: 14,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLatestOffers() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Offers',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }
}
