import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'placeholder_screen.dart';
import 'today_screen.dart';

class _Tab {
  const _Tab(this.label, this.icon);

  final String label;
  final IconData icon;
}

const _tabs = [
  _Tab('Today', Icons.grid_view_rounded),
  _Tab('Nutrition', Icons.restaurant_rounded),
  _Tab('Activity', Icons.local_fire_department_rounded),
  _Tab('Habits', Icons.water_drop_rounded),
];

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const _WellsyHeader(),
      body: IndexedStack(
        index: _index,
        children: [
          const TodayScreen(),
          for (final tab in _tabs.skip(1)) PlaceholderScreen(title: tab.label, icon: tab.icon),
        ],
      ),
      bottomNavigationBar: _WellsyNavBar(
        index: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}

/// Frosted glass blur used by the header and nav bar.
class _Frosted extends StatelessWidget {
  const _Frosted({required this.child, required this.shadow, this.opacity = 0.85});

  final Widget child;
  final BoxShadow shadow;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [shadow]),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: ColoredBox(
            color: AppColors.surface.withValues(alpha: opacity),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _WellsyHeader extends StatelessWidget implements PreferredSizeWidget {
  const _WellsyHeader();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', //
  ];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return _Frosted(
      shadow: const BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 1)),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Wellsy',
                              style: AppText.headlineSm.copyWith(
                                  fontWeight: FontWeight.w700, letterSpacing: -0.45)),
                          const SizedBox(width: 4),
                          const Dot(color: AppColors.primaryContainer),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded,
                              size: 13, color: AppColors.primary),
                          const SizedBox(width: 4),
                          Text('Today, ${_months[now.month - 1]} ${now.day}',
                              style: AppText.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Profile',
                  onPressed: () {},
                  icon: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2)),
                      ],
                    ),
                    child: const Icon(Icons.person_rounded,
                        size: 20, color: AppColors.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WellsyNavBar extends StatelessWidget {
  const _WellsyNavBar({required this.index, required this.onChanged});

  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return _Frosted(
      opacity: 0.9,
      shadow: const BoxShadow(color: Color(0x0D0F172A), blurRadius: 20, offset: Offset(0, -4)),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < _tabs.length; i++)
                  Flexible(
                    child: _NavItem(tab: _tabs[i], active: i == index, onTap: () => onChanged(i)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.tab, required this.active, required this.onTap});

  final _Tab tab;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant;
    return Semantics(
      selected: active,
      button: true,
      label: tab.label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(minWidth: 56, minHeight: 44),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryFixed : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(tab.icon, size: 22, color: color),
              const SizedBox(height: 2),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(tab.label,
                    maxLines: 1,
                    style: AppText.labelSm.copyWith(
                      color: color,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w600,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
