import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const WellsyApp());

class WellsyApp extends StatelessWidget {
  const WellsyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: C.surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: C.primaryContainer,
        surface: C.surface,
      ),
    );
    return MaterialApp(
      title: 'Wellsy',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: base.textTheme
            .apply(fontFamily: GoogleFonts.plusJakartaSans().fontFamily),
      ),
      home: const WellsyShell(),
    );
  }
}

/// Shared header + bottom navigation; swaps the body per tab.
class WellsyShell extends StatefulWidget {
  const WellsyShell({super.key});

  @override
  State<WellsyShell> createState() => _WellsyShellState();
}

class _WellsyShellState extends State<WellsyShell> {
  int _index = 3; // Habits

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: C.surface,
      extendBody: true,
      appBar: const WHeader(),
      body: IndexedStack(
        index: _index,
        children: const [
          _Placeholder('Today'),
          _Placeholder('Nutrition'),
          ActivityScreen(),
          HabitsScreen(),
        ],
      ),
      bottomNavigationBar: WBottomNav(
        index: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final String label;
  const _Placeholder(this.label);

  @override
  Widget build(BuildContext context) => Center(
        child: Text('$label — coming soon',
            style: wt(14, color: C.onSurfaceVariant)),
      );
}

// ═════════════ THEME ═════════════
// ───────────────────────── Design tokens ─────────────────────────
class C {
  static const surface = Color(0xFFFAF8FF);
  static const surfaceLowest = Color(0xFFFFFFFF);
  static const surfaceLow = Color(0xFFF2F3FF);
  static const surfaceContainer = Color(0xFFEAEDFF);
  static const surfaceContainerHighest = Color(0xFFDAE2FD);
  static const surfaceDim = Color(0xFFD2D9F4);
  static const onSurface = Color(0xFF131B2E);
  static const onSurfaceVariant = Color(0xFF5B403A);
  static const primary = Color(0xFFB72301);
  static const primaryContainer = Color(0xFFFF5733);
  static const primaryFixed = Color(0xFFFFDAD3);
  static const primaryFixedDim = Color(0xFFFFB4A4);
  static const onPrimaryContainer = Color(0xFF580C00);
  static const onPrimaryFixedVariant = Color(0xFF8C1800);
  static const secondary = Color(0xFF006688);
  static const secondaryContainer = Color(0xFF43C5FD);
  static const secondaryFixed = Color(0xFFC2E8FF);
  static const secondaryFixedDim = Color(0xFF77D1FF);
  static const onSecondaryFixed = Color(0xFF001E2C);
  static const onSecondaryFixedVariant = Color(0xFF004D68);
  static const tertiaryContainer = Color(0xFF00A673);
  static const tertiaryFixed = Color(0xFF6FFBBE);
  static const onTertiaryFixedVariant = Color(0xFF005236);
  static const inverseSurface = Color(0xFF283044);
  static const inverseOnSurface = Color(0xFFEEF0FF);
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const onErrorContainer = Color(0xFF93000A);
  static const tertiary = Color(0xFF006C49);
  static const onTertiaryFixed = Color(0xFF002113);
  static const onPrimaryFixed = Color(0xFF3D0600);
  static const surfaceContainerHigh = Color(0xFFE2E7FF);
  static const surfaceVariantOutline = Color(0xFFE4BEB6);
}

const double rDefault = 16;
const double rLg = 32;

TextStyle wt(double size,
    {FontWeight w = FontWeight.w400,
    Color color = C.onSurface,
    double? height,
    double? ls}) {
  return GoogleFonts.plusJakartaSans(
    fontSize: size,
    fontWeight: w,
    color: color,
    height: height != null ? height / size : null,
    letterSpacing: ls,
  );
}


/// Gently pulses its child's opacity (mirrors Tailwind's animate-pulse).
class Pulse extends StatefulWidget {
  final Widget child;
  const Pulse({super.key, required this.child});

  @override
  State<Pulse> createState() => _PulseState();
}

class _PulseState extends State<Pulse> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FadeTransition(opacity: Tween(begin: 1.0, end: 0.5).animate(_c), child: widget.child);
}

// ───────────────────────── Header ─────────────────────────
class WHeader extends StatelessWidget implements PreferredSizeWidget {
  const WHeader();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: C.surface.withOpacity(0.92),
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.04),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Wellsy',
                              style: wt(18,
                                  w: FontWeight.w700, height: 24, ls: -0.2)),
                          const SizedBox(width: 4),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: C.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 13, color: C.primary),
                          const SizedBox(width: 4),
                          Text('Today, Oct 24',
                              style: wt(11,
                                  w: FontWeight.w700,
                                  color: C.onSurfaceVariant,
                                  ls: 0.44)),
                        ],
                      ),
                    ],
                  ),
                  const WProfileButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Default faceless avatar: soft circle with a generic person silhouette.
class WProfileButton extends StatelessWidget {
  const WProfileButton();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Profile',
      button: true,
      child: InkResponse(
        onTap: () {},
        radius: 24,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Center(
            child: Container(
              width: 32,
              height: 32,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: C.surfaceContainerHighest,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const CustomPaint(painter: DefaultAvatarPainter()),
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultAvatarPainter extends CustomPainter {
  const DefaultAvatarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = C.onSurfaceVariant.withOpacity(0.45);
    final w = size.width;
    final h = size.height;
    // head
    canvas.drawCircle(Offset(w / 2, h * 0.38), w * 0.19, paint);
    // shoulders
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(w / 2, h * 0.95), width: w * 0.78, height: h * 0.72),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ───────────────────────── Shared card ─────────────────────────
class WCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final bool shadow;

  const WCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = C.surfaceLowest,
    this.shadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(rLg),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

// ───────────────────────── Bottom nav ─────────────────────────
class WBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const WBottomNav({required this.index, required this.onChanged});

  static const _items = <(String, IconData)>[
    ('Today', Icons.grid_view),
    ('Nutrition', Icons.restaurant),
    ('Activity', Icons.local_fire_department),
    ('Habits', Icons.water_drop),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.surface.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < _items.length; i++)
                NavItem(
                  label: _items[i].$1,
                  icon: _items[i].$2,
                  active: i == index,
                  onTap: () => onChanged(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const NavItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = active ? C.onPrimaryContainer : C.onSurfaceVariant;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minWidth: 56, minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: active ? C.primaryFixed : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: fg),
            const SizedBox(height: 2),
            Text(label,
                style: wt(11,
                    w: FontWeight.w700, color: fg, height: 14, ls: 0.44)),
          ],
        ),
      ),
    );
  }
}

// ═════════════ ACTIVITY_SCREEN ═════════════



class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: const [
        _StreakCard(),
        SizedBox(height: 16),
        _CalorieCard(),
        SizedBox(height: 16),
        _WorkoutBanner(),
        SizedBox(height: 16),
        _StepsCard(),
        SizedBox(height: 16),
        _CompletedWorkouts(),
        SizedBox(height: 16),
        _MilestoneBanner(),
      ],
    );
  }
}

// ───────────────────────── Streak card ─────────────────────────
class _StreakCard extends StatelessWidget {
  const _StreakCard();

  @override
  Widget build(BuildContext context) {
    return WCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_fire_department,
                      size: 20, color: C.primaryContainer),
                  const SizedBox(width: 4),
                  Text('5-Day Active Streak',
                      style: wt(18, w: FontWeight.w600, height: 24)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: C.primaryFixed,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('In the Zone',
                    style: wt(11,
                        w: FontWeight.w700,
                        color: C.onPrimaryFixedVariant,
                        ls: 0.44)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Day('M', done: true),
              _Day('T', done: true),
              _Day('W', done: true),
              _Day('T', done: true),
              _Day('F', today: true),
              _Day('S', number: '26'),
              _Day('S', number: '27'),
            ],
          ),
        ],
      ),
    );
  }
}

class _Day extends StatefulWidget {
  final String label;
  final bool done;
  final bool today;
  final String? number;

  const _Day(this.label, {this.done = false, this.today = false, this.number});

  @override
  State<_Day> createState() => _DayState();
}

class _DayState extends State<_Day> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    if (widget.today) _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filled = widget.done || widget.today;
    Widget circle = Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: filled ? C.primaryContainer : C.surfaceContainer,
        shape: BoxShape.circle,
        boxShadow: widget.today
            ? [
                BoxShadow(
                  color: C.primaryContainer.withOpacity(0.35),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: widget.today
          ? const Icon(Icons.local_fire_department,
              size: 18, color: Colors.white)
          : widget.done
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : Text(widget.number ?? '',
                  style: wt(11,
                      w: FontWeight.w700,
                      color: C.onSurfaceVariant,
                      ls: 0.44)),
    );
    if (widget.today) {
      circle = FadeTransition(
        opacity: Tween(begin: 1.0, end: 0.6).animate(_ctrl),
        child: circle,
      );
    }
    return Column(
      children: [
        Text(widget.label,
            style: wt(11,
                w: FontWeight.w700,
                color: widget.today ? C.primary : C.onSurfaceVariant,
                ls: 0.44)),
        const SizedBox(height: 4),
        circle,
      ],
    );
  }
}

// ───────────────────────── Calorie card ─────────────────────────
class _CalorieCard extends StatelessWidget {
  const _CalorieCard();

  @override
  Widget build(BuildContext context) {
    return WCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: C.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('ACTIVE BURNOUT',
                          style: wt(13,
                              w: FontWeight.w600,
                              color: C.onSurfaceVariant,
                              ls: 1.0)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('680',
                          style: wt(34,
                              w: FontWeight.w800, height: 42, ls: -0.7)),
                      const SizedBox(width: 4),
                      Text('kcal',
                          style: wt(18,
                              w: FontWeight.w700,
                              color: C.onSurfaceVariant,
                              height: 24)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(80, 80),
                      painter: _RingPainter(progress: 0.9),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('90%',
                            style: wt(18,
                                w: FontWeight.w700,
                                color: C.primaryContainer,
                                height: 18)),
                        Text('GOAL',
                            style: wt(10,
                                w: FontWeight.w700,
                                color: C.onSurfaceVariant,
                                ls: 0.4)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Daily Target: 750 kcal',
                        style: wt(12, color: C.onSurfaceVariant, ls: 0.12)),
                    Text('70 kcal left',
                        style: wt(13, w: FontWeight.w700, color: C.primary)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 0.9),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (_, v, __) => LinearProgressIndicator(
                      value: v,
                      minHeight: 10,
                      backgroundColor: C.surfaceContainer,
                      valueColor:
                          const AlwaysStoppedAnimation(C.primaryContainer),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: _SubMetric(
                  icon: Icons.bolt,
                  iconColor: C.primaryContainer,
                  label: 'Active Output',
                  value: '455 kcal',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _SubMetric(
                  icon: Icons.bedtime,
                  iconColor: C.secondary,
                  label: 'Basal (Rest)',
                  value: '225 kcal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * (30 / 72);
    final stroke = size.width * (6 / 72);
    final track = Paint()
      ..color = C.surfaceContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    final arc = Paint()
      ..color = C.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = stroke;
    canvas.drawCircle(center, radius, track);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.progress != progress;
}

class _SubMetric extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _SubMetric({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: C.surfaceLow,
        borderRadius: BorderRadius.circular(rDefault),
      ),
      child: Row(
        children: [
          _CircleIcon(icon: icon, color: iconColor, size: 36, iconSize: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    overflow: TextOverflow.ellipsis,
                    style: wt(11,
                        w: FontWeight.w700,
                        color: C.onSurfaceVariant,
                        ls: 0.44)),
                Text(value,
                    overflow: TextOverflow.ellipsis,
                    style: wt(18, w: FontWeight.w700, height: 24)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final double iconSize;

  const _CircleIcon({
    required this.icon,
    required this.color,
    required this.size,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: C.surfaceLowest,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Icon(icon, size: iconSize, color: color),
    );
  }
}

// ───────────────────────── Workout banner ─────────────────────────
class _WorkoutBanner extends StatefulWidget {
  const _WorkoutBanner();

  @override
  State<_WorkoutBanner> createState() => _WorkoutBannerState();
}

class _WorkoutBannerState extends State<_WorkoutBanner> {
  static const _workouts = <(String, IconData, Color)>[
    ('HIIT', Icons.timer, C.primaryContainer),
    ('Strength', Icons.fitness_center, C.tertiaryFixed),
    ('Running', Icons.directions_run, C.secondaryContainer),
    ('Cycling', Icons.directions_bike, C.primaryFixedDim),
    ('Walking', Icons.directions_walk, C.surface),
  ];

  String? _selected;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return WCard(
      color: C.inverseSurface,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.fitness_center,
                      size: 22, color: C.tertiaryFixed),
                  const SizedBox(width: 4),
                  Text('Ready to Train?',
                      style: wt(18,
                          w: FontWeight.w700,
                          color: C.inverseOnSurface,
                          height: 24)),
                ],
              ),
              Text('AUTO-SYNC',
                  style: wt(11,
                      w: FontWeight.w700, color: C.tertiaryFixed, ls: 0.44)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Select an activity to begin biometric heart-rate cadence monitoring.',
            style: wt(12, color: C.surfaceDim, height: 16, ls: 0.12),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final w in _workouts)
                _WorkoutChip(
                  label: w.$1,
                  icon: w.$2,
                  iconColor: w.$3,
                  selected: _selected == w.$1,
                  onTap: () => setState(() => _selected = w.$1),
                ),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedScale(
            scale: _pressed ? 0.95 : 1,
            duration: const Duration(milliseconds: 150),
            child: SizedBox(
              width: double.infinity,
              child: Material(
                color: C.primaryContainer,
                elevation: 3,
                shadowColor: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () async {
                    setState(() => _pressed = true);
                    await Future.delayed(const Duration(milliseconds: 150));
                    if (mounted) setState(() => _pressed = false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.play_arrow,
                            size: 20, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          _selected == null
                              ? 'Start Active Workout'
                              : 'Start $_selected Workout',
                          style: wt(18,
                              w: FontWeight.w700,
                              color: Colors.white,
                              height: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final bool selected;
  final VoidCallback onTap;

  const _WorkoutChip({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = selected ? Colors.white : C.inverseOnSurface;
    return Material(
      color: selected
          ? C.primaryContainer
          : C.inverseOnSurface.withOpacity(0.10),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: selected ? Colors.white : iconColor),
              const SizedBox(width: 4),
              Text(label,
                  style: wt(13, w: FontWeight.w600, color: fg, ls: 0.26)),
            ],
          ),
        ),
      ),
    );
  }
}

// ───────────────────────── Steps card ─────────────────────────
class _StepsCard extends StatelessWidget {
  const _StepsCard();

  // label, height fraction, peak label (if peak)
  static const _bars = <(String, double, String?)>[
    ('6a', 0.18, null),
    ('7a', 0.38, null),
    ('8a', 0.86, '1.8k'),
    ('9a', 0.25, null),
    ('10a', 0.20, null),
    ('11a', 0.34, null),
    ('12p', 0.98, '2.1k'),
    ('1p', 0.42, null),
    ('2p', 0.30, null),
    ('3p', 0.15, 'dim'),
  ];

  @override
  Widget build(BuildContext context) {
    return WCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('STEP CADENCE',
                      style: wt(13,
                          w: FontWeight.w600,
                          color: C.onSurfaceVariant,
                          ls: 1.0)),
                  const SizedBox(height: 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('8,420',
                          style: wt(28,
                              w: FontWeight.w800, height: 32, ls: -0.8)),
                      const SizedBox(width: 4),
                      Text('/ 10,000 steps',
                          style: wt(12, color: C.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: C.secondaryFixed,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.directions_walk,
                    size: 22, color: C.onSecondaryFixed),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(
                child: _StatPill(
                  icon: Icons.straighten,
                  color: C.secondary,
                  label: 'Distance',
                  value: '6.2 km',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _StatPill(
                  icon: Icons.stairs,
                  color: C.primaryContainer,
                  label: 'Floors',
                  value: '14 fl',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hourly Activity Distribution',
                  style: wt(13, w: FontWeight.w600, ls: 0.26)),
              Text('Peak: 8am & 12pm',
                  style: wt(11,
                      w: FontWeight.w700, color: C.primary, ls: 0.44)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            decoration: BoxDecoration(
              color: C.surfaceLow,
              borderRadius: BorderRadius.circular(rDefault),
            ),
            child: SizedBox(
              height: 112,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final b in _bars) Expanded(child: _Bar(b)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final (String, double, String?) data;
  const _Bar(this.data);

  @override
  Widget build(BuildContext context) {
    final (label, frac, tag) = data;
    final isPeak = tag != null && tag != 'dim';
    final color = isPeak
        ? C.primaryContainer
        : tag == 'dim'
            ? C.surfaceContainerHighest
            : C.secondaryFixedDim;
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, c) {
              return Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 14,
                    height: c.maxHeight * frac,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(2)),
                    ),
                  ),
                  if (isPeak)
                    Positioned(
                      bottom: c.maxHeight * frac + 2,
                      child: Text(tag,
                          style: wt(9,
                              w: FontWeight.w800, color: C.primaryContainer)),
                    ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        Text(label,
            style: wt(10,
                w: isPeak ? FontWeight.w700 : FontWeight.w700,
                color: isPeak ? C.primaryContainer : C.onSurfaceVariant)),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatPill({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: C.surfaceLow,
        borderRadius: BorderRadius.circular(rDefault),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: C.surfaceLowest,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: wt(11,
                      w: FontWeight.w700,
                      color: C.onSurfaceVariant,
                      ls: 0.44)),
              Text(value, style: wt(18, w: FontWeight.w700, height: 24)),
            ],
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Completed workouts ─────────────────────────
class _CompletedWorkouts extends StatelessWidget {
  const _CompletedWorkouts();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Completed Workouts",
                  style: wt(18, w: FontWeight.w700, height: 24)),
              Text('2 Sessions',
                  style: wt(13, w: FontWeight.w600, color: C.primary)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _WorkoutTile(
          icon: Icons.timer,
          iconBg: C.primaryFixed,
          iconColor: C.primary,
          title: 'Morning HIIT & Mobility',
          time: '07:30 AM',
          duration: '35 min',
          kcal: '310 kcal',
          kcalColor: C.primary,
          bpm: '148 bpm avg',
          tagBg: C.primaryFixed,
          tagFg: C.onPrimaryFixedVariant,
          tag: 'Zone 4 (Peak Threshold)',
          tagLeading: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: C.primaryContainer,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        const _WorkoutTile(
          icon: Icons.directions_walk,
          iconBg: C.secondaryFixed,
          iconColor: C.secondary,
          title: 'Afternoon Power Walk',
          time: '01:15 PM',
          duration: '25 min',
          kcal: '145 kcal',
          kcalColor: C.secondary,
          bpm: '112 bpm avg',
          tagBg: C.secondaryFixed,
          tagFg: C.onSecondaryFixedVariant,
          tag: 'Riverside Loop (2.4 km)',
          tagLeading: Icon(Icons.explore, size: 14, color: C.secondary),
        ),
      ],
    );
  }
}

class _WorkoutTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String time;
  final String duration;
  final String kcal;
  final Color kcalColor;
  final String bpm;
  final Color tagBg;
  final Color tagFg;
  final String tag;
  final Widget tagLeading;

  const _WorkoutTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.duration,
    required this.kcal,
    required this.kcalColor,
    required this.bpm,
    required this.tagBg,
    required this.tagFg,
    required this.tag,
    required this.tagLeading,
  });

  @override
  Widget build(BuildContext context) {
    return WCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(rLg),
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(title,
                          overflow: TextOverflow.ellipsis,
                          style: wt(18, w: FontWeight.w700, height: 24)),
                    ),
                    const SizedBox(width: 6),
                    Text(time,
                        style: wt(11,
                            w: FontWeight.w700,
                            color: C.onSurfaceVariant,
                            ls: 0.44)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(duration,
                        style: wt(12, color: C.onSurfaceVariant, ls: 0.12)),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: C.onSurfaceVariant.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(kcal,
                        style: wt(12,
                            w: FontWeight.w700, color: kcalColor, ls: 0.12)),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _Pill(
                      bg: C.surfaceLow,
                      leading:
                          const Icon(Icons.favorite, size: 14, color: C.error),
                      text: bpm,
                      fg: C.onSurface,
                    ),
                    _Pill(
                      bg: tagBg,
                      leading: tagLeading,
                      text: tag,
                      fg: tagFg,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final Color bg;
  final Color fg;
  final Widget leading;
  final String text;

  const _Pill({
    required this.bg,
    required this.fg,
    required this.leading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          const SizedBox(width: 4),
          Text(text,
              style: wt(11, w: FontWeight.w700, color: fg, ls: 0.44)),
        ],
      ),
    );
  }
}

// ───────────────────────── Milestone banner ─────────────────────────
class _MilestoneBanner extends StatelessWidget {
  const _MilestoneBanner();

  @override
  Widget build(BuildContext context) {
    return WCard(
      color: C.tertiaryFixed.withOpacity(0.3),
      shadow: false,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: C.tertiaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.emoji_events,
                size: 22, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Calorie Milestone Approaching!',
                    overflow: TextOverflow.ellipsis,
                    style: wt(18,
                        w: FontWeight.w700,
                        color: C.onTertiaryFixedVariant,
                        height: 24)),
                Text('Just a 10-minute jog away from beating your weekly high.',
                    style: wt(12,
                        color: C.onTertiaryFixedVariant,
                        height: 16,
                        ls: 0.12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════ HABITS_SCREEN ═════════════
String _fmt(int n) {
  final s = n.toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
    buf.write(s[i]);
  }
  return buf.toString();
}

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  static const int _goal = 2500;
  int _intake = 1750;
  bool _doseTaken = false;
  bool _snoozed = false;

  void _logWater(int ml) =>
      setState(() => _intake = (_intake + ml).clamp(0, 3000));

  @override
  Widget build(BuildContext context) {
    final pct = ((_intake / _goal) * 100).round().clamp(0, 100);
    final left = (_goal - _intake).clamp(0, _goal);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        const _StreakBanner(),
        const SizedBox(height: 16),
        _HydrationCard(
          intake: _intake,
          goal: _goal,
          pct: pct,
          left: left,
          onLog: _logWater,
        ),
        const SizedBox(height: 16),
        _MedicationsCard(
          taken: _doseTaken,
          snoozed: _snoozed,
          onTake: () => setState(() => _doseTaken = true),
          onSnooze: () => setState(() => _snoozed = true),
        ),
      ],
    );
  }
}

// ───────────────────────── Streak banner ─────────────────────────
class _StreakBanner extends StatelessWidget {
  const _StreakBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(rLg),
      child: Stack(
        children: [
          WCard(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: C.secondaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.local_fire_department,
                      size: 24, color: C.onSecondaryFixed),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('14-Day Streak',
                              style: wt(18, w: FontWeight.w600, height: 24)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: C.tertiaryFixed,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text('Perfect',
                                style: wt(11,
                                    w: FontWeight.w700,
                                    color: C.onTertiaryFixed,
                                    ls: 0.44)),
                          ),
                        ],
                      ),
                      Text('Hydration & medications perfectly on track',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: wt(12, color: C.onSurfaceVariant, ls: 0.12)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: C.surfaceContainer,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: const SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(Icons.chevron_right,
                          size: 18, color: C.onSurface),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // soft glow, top-right
          Positioned(
            right: -16,
            top: -32,
            child: IgnorePointer(
              child: Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      C.secondaryContainer.withOpacity(0.28),
                      C.secondaryContainer.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Hydration ─────────────────────────
class _HydrationCard extends StatelessWidget {
  final int intake;
  final int goal;
  final int pct;
  final int left;
  final ValueChanged<int> onLog;

  const _HydrationCard({
    required this.intake,
    required this.goal,
    required this.pct,
    required this.left,
    required this.onLog,
  });

  @override
  Widget build(BuildContext context) {
    return WCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: C.secondaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('Hydration Tracker',
                      style: wt(18, w: FontWeight.w600, height: 24)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: C.secondaryFixed,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('$pct% Reached',
                    style: wt(11,
                        w: FontWeight.w700,
                        color: C.onSecondaryFixed,
                        ls: 0.44)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Gauge + readout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: C.surfaceLow,
              borderRadius: BorderRadius.circular(rDefault),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(child: _WaterGauge(fraction: intake / goal)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('CURRENT INTAKE',
                          style: wt(11,
                              w: FontWeight.w700,
                              color: C.onSurfaceVariant,
                              ls: 0.44)),
                      const SizedBox(height: 4),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(_fmt(intake),
                                style: wt(34,
                                    w: FontWeight.w800, height: 34, ls: -0.7)),
                            const SizedBox(width: 4),
                            Text('/ ${_fmt(goal)} ml',
                                style: wt(12, color: C.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        left > 0
                            ? TextSpan(children: [
                                TextSpan(
                                    text: '$left ml left',
                                    style: wt(12,
                                        w: FontWeight.w700,
                                        color: C.secondary)),
                                TextSpan(
                                    text: ' to hit daily target.',
                                    style: wt(12, color: C.onSurfaceVariant)),
                              ])
                            : TextSpan(
                                text: 'Daily target reached!',
                                style: wt(12,
                                    w: FontWeight.w700, color: C.secondary)),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.trending_up,
                              size: 16, color: C.tertiary),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text('+250 ml ahead of yesterday',
                                style: wt(11,
                                    w: FontWeight.w700,
                                    color: C.tertiary,
                                    ls: 0.44)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('QUICK LOG',
              style: wt(11,
                  w: FontWeight.w700, color: C.onSurfaceVariant, ls: 0.44)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                  child: _LogPod(
                      icon: Icons.local_cafe,
                      amount: 200,
                      name: 'Cup',
                      onTap: onLog)),
              const SizedBox(width: 12),
              Expanded(
                  child: _LogPod(
                      icon: Icons.emoji_food_beverage,
                      amount: 350,
                      name: 'Mug',
                      onTap: onLog)),
              const SizedBox(width: 12),
              Expanded(
                  child: _LogPod(
                      icon: Icons.local_drink,
                      amount: 500,
                      name: 'Bottle',
                      onTap: onLog)),
              const SizedBox(width: 12),
              Expanded(
                  child: _LogPod(
                      icon: Icons.sports_gymnastics,
                      amount: 750,
                      name: 'Flask',
                      onTap: onLog)),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('HYDRATION SCHEDULE',
                    style: wt(11,
                        w: FontWeight.w700,
                        color: C.onSurfaceVariant,
                        ls: 0.44)),
                Text('Smart Reminders',
                    style: wt(11,
                        w: FontWeight.w700, color: C.secondary, ls: 0.44)),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: C.surfaceLow,
              borderRadius: BorderRadius.circular(rDefault),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  const _ScheduleSlot(
                      time: '8:00 AM', note: '500ml logged', done: true),
                  _connector(),
                  const _ScheduleSlot(
                      time: '11:00 AM', note: '450ml logged', done: true),
                  _connector(),
                  const _ScheduleSlot(
                      time: '2:00 PM', note: 'Next (350ml)', done: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _connector() => Container(
        width: 16,
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        color: C.surfaceDim,
      );
}

class _WaterGauge extends StatelessWidget {
  final double fraction;
  const _WaterGauge({required this.fraction});

  @override
  Widget build(BuildContext context) {
    const h = 144.0;
    final f = fraction.clamp(0.0, 1.0);
    return Container(
      width: 80,
      height: h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: C.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOut,
              width: double.infinity,
              height: h * f,
              color: C.secondaryContainer,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: C.secondaryFixed.withOpacity(0.75),
                  ),
                  const SizedBox(height: 12),
                  Pulse(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: C.surfaceLowest.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            bottom: 8,
            right: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final m in const ['2.5L', '1.8L', '1.0L', '0.2L'])
                  Text(m,
                      style: wt(9,
                          w: FontWeight.w700,
                          color: C.onSurfaceVariant.withOpacity(0.4))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogPod extends StatelessWidget {
  final IconData icon;
  final int amount;
  final String name;
  final ValueChanged<int> onTap;

  const _LogPod({
    required this.icon,
    required this.amount,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: C.surfaceContainer,
      borderRadius: BorderRadius.circular(rDefault),
      child: InkWell(
        borderRadius: BorderRadius.circular(rDefault),
        splashColor: C.secondaryFixed,
        onTap: () => onTap(amount),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(icon, size: 22, color: C.secondary),
              const SizedBox(height: 4),
              Text('+${amount}ml',
                  maxLines: 1,
                  style: wt(11, w: FontWeight.w700, ls: 0.44)),
              Text(name,
                  style: wt(10, color: C.onSurfaceVariant)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleSlot extends StatelessWidget {
  final String time;
  final String note;
  final bool done;

  const _ScheduleSlot(
      {required this.time, required this.note, required this.done});

  @override
  Widget build(BuildContext context) {
    final icon = done
        ? const Icon(Icons.check_circle, size: 18, color: C.tertiary)
        : const Pulse(
            child: Icon(Icons.schedule, size: 18, color: C.secondary));
    return Row(
      children: [
        icon,
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(time, style: wt(11, w: FontWeight.w700, ls: 0.44)),
            Text(note,
                style: wt(10,
                    w: FontWeight.w700,
                    color: done ? C.tertiary : C.secondary)),
          ],
        ),
      ],
    );
  }
}

// ───────────────────────── Medications ─────────────────────────
class _MedicationsCard extends StatelessWidget {
  final bool taken;
  final bool snoozed;
  final VoidCallback onTake;
  final VoidCallback onSnooze;

  const _MedicationsCard({
    required this.taken,
    required this.snoozed,
    required this.onTake,
    required this.onSnooze,
  });

  @override
  Widget build(BuildContext context) {
    return WCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: C.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('Medications & Rx',
                      style: wt(18, w: FontWeight.w600, height: 24)),
                ],
              ),
              Text(taken ? '1 of 3 remaining' : '2 of 3 remaining',
                  style: wt(11,
                      w: FontWeight.w700,
                      color: C.onSurfaceVariant,
                      ls: 0.44)),
            ],
          ),
          const SizedBox(height: 16),
          // Refill alert
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: C.errorContainer.withOpacity(0.4),
              borderRadius: BorderRadius.circular(rDefault),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: C.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.inventory_2,
                      size: 18, color: C.onErrorContainer),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Magnesium Glycinate',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: wt(13, w: FontWeight.w700, ls: 0.26)),
                      Text('4 doses remaining • Refill soon',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: wt(12,
                              color: C.onErrorContainer, ls: 0.12)),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Material(
                  color: C.surfaceLowest,
                  elevation: 1,
                  shadowColor: Colors.black26,
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text('Order',
                          style: wt(11, w: FontWeight.w700, ls: 0.44)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 1: completed
          const _MedRow(
            done: true,
            icon: Icons.check,
            iconBg: C.tertiaryFixed,
            iconFg: C.onTertiaryFixed,
            title: 'Multivitamin + Omega-3',
            pill: '8:00 AM',
            sub: '1 Softgel • Taken with breakfast',
            dim: true,
          ),
          const SizedBox(height: 8),
          // 2: actionable / taken
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: taken
                ? const _MedRow(
                    key: ValueKey('taken'),
                    done: true,
                    icon: Icons.check,
                    iconBg: C.tertiaryFixed,
                    iconFg: C.onTertiaryFixed,
                    title: 'Vit D3 2000 IU + Iron',
                    pill: 'Just now',
                    sub: 'Logged • Adherence recorded',
                    dim: true,
                  )
                : _DueDoseCard(
                    key: const ValueKey('due'),
                    snoozed: snoozed,
                    onSnooze: onSnooze,
                    onTake: onTake,
                  ),
          ),
          const SizedBox(height: 8),
          // 3: upcoming
          const _MedRow(
            done: false,
            icon: Icons.bedtime,
            iconBg: C.surfaceContainer,
            iconFg: C.onSurfaceVariant,
            title: 'Magnesium Glycinate 400mg',
            pill: '9:30 PM',
            sub: '2 Capsules • 30 min before bed',
          ),
        ],
      ),
    );
  }
}

class _MedRow extends StatelessWidget {
  final bool done;
  final IconData icon;
  final Color iconBg;
  final Color iconFg;
  final String title;
  final String pill;
  final String sub;
  final bool dim;

  const _MedRow({
    super.key,
    required this.done,
    required this.icon,
    required this.iconBg,
    required this.iconFg,
    required this.title,
    required this.pill,
    required this.sub,
    this.dim = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: dim ? 0.85 : 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: C.surfaceLow,
          borderRadius: BorderRadius.circular(rDefault),
        ),
        child: Row(
          children: [
            _MedIcon(icon: icon, bg: iconBg, fg: iconFg),
            const SizedBox(width: 8),
            Expanded(child: _MedText(title: title, pill: pill, sub: sub)),
            const SizedBox(width: 8),
            Icon(
              done ? Icons.task_alt : Icons.radio_button_unchecked,
              size: 20,
              color: done ? C.tertiary : C.surfaceVariantOutline,
            ),
          ],
        ),
      ),
    );
  }
}

class _MedIcon extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final Color fg;
  const _MedIcon({required this.icon, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, size: 20, color: fg),
      );
}

class _MedText extends StatelessWidget {
  final String title;
  final String pill;
  final String sub;
  final Color pillBg;
  final Color pillFg;

  const _MedText({
    required this.title,
    required this.pill,
    required this.sub,
    this.pillBg = C.surfaceContainer,
    this.pillFg = C.onSurfaceVariant,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: wt(13, w: FontWeight.w700, ls: 0.26)),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: pillBg,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(pill,
                  style: wt(10, w: FontWeight.w700, color: pillFg, ls: 0.4)),
            ),
          ],
        ),
        Text(sub,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: wt(12, color: C.onSurfaceVariant, ls: 0.12)),
      ],
    );
  }
}

class _DueDoseCard extends StatelessWidget {
  final bool snoozed;
  final VoidCallback onSnooze;
  final VoidCallback onTake;

  const _DueDoseCard({
    super.key,
    required this.snoozed,
    required this.onSnooze,
    required this.onTake,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: C.surfaceLowest,
        borderRadius: BorderRadius.circular(rDefault),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const _MedIcon(
                  icon: Icons.medication,
                  bg: C.secondaryFixed,
                  fg: C.onSecondaryFixed),
              const SizedBox(width: 8),
              const Expanded(
                child: _MedText(
                  title: 'Vit D3 2000 IU + Iron',
                  pill: '1:00 PM',
                  sub: '1 Tablet • With afternoon meal',
                  pillBg: C.secondaryFixed,
                  pillFg: C.onSecondaryFixedVariant,
                ),
              ),
              const SizedBox(width: 8),
              Pulse(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: C.primaryFixed,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('DUE',
                      style: wt(10,
                          w: FontWeight.w700, color: C.onPrimaryFixed)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Material(
                  color: snoozed ? C.secondaryFixed : C.surfaceContainer,
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: onSnooze,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(snoozed ? Icons.alarm_on : Icons.snooze,
                              size: 16,
                              color:
                                  snoozed ? C.onSecondaryFixed : C.onSurface),
                          const SizedBox(width: 4),
                          Text(snoozed ? 'Snoozed +15m' : 'Snooze 15m',
                              style: wt(13,
                                  w: FontWeight.w600,
                                  color: snoozed
                                      ? C.onSecondaryFixed
                                      : C.onSurface,
                                  ls: 0.26)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Material(
                  color: C.primaryContainer,
                  elevation: 1,
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: onTake,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle,
                              size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text('Take Now',
                              style: wt(13,
                                  w: FontWeight.w600,
                                  color: Colors.white,
                                  ls: 0.26)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
