import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../viewmodels/profile_viewmodel.dart';
import '../widgets/profile/menu_card.dart';
import '../widgets/profile/menu_item.dart';
import '../widgets/profile/profile_stats_card.dart';

/// Profile tab: account summary and settings list.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel vm = context.watch<ProfileViewModel>();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        children: <Widget>[
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              letterSpacing: -1.0,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: <Widget>[
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[AppColors.accent, Color(0xFFFF8A5B)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      vm.userName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      vm.email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.inkSecondary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      vm.memberSince,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ProfileStatsCard(vm: vm),
          const SizedBox(height: 26),
          const MenuCard(
            items: <MenuItem>[
              MenuItem(Icons.settings_outlined, 'Settings'),
              MenuItem(Icons.notifications_none_rounded, 'Notifications'),
              MenuItem(Icons.file_download_outlined, 'Export data'),
              MenuItem(Icons.help_outline_rounded, 'Help & support'),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => _notImplemented(context, 'Log out'),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Log out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.accent,
              side: const BorderSide(color: AppColors.accent, width: 1.4),
            ),
          ),
          const SizedBox(height: 18),
          const Center(
            child: Text(
              'expense_tracker · v1.0.0',
              style: TextStyle(fontSize: 12, color: AppColors.inkTertiary),
            ),
          ),
        ],
      ),
    );
  }

  void _notImplemented(BuildContext context, String label) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('$label is not part of this prototype')),
      );
  }
}
