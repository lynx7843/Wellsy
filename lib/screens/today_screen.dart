import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/painters.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final insets = MediaQuery.paddingOf(context);
    return ListView(
      padding: EdgeInsets.fromLTRB(16, insets.top,16, insets.bottom + 24),
      children: const [
        _ReadinessBanner(),
        SizedBox(height: 16),
        _EnergyOverviewCard(),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _StepsCard()),
            SizedBox(width: 12),
            Expanded(child: _BurnCard()),
          ],
        ),
        SizedBox(height: 16),
        _HydrationCard(),
        SizedBox(height: 16),
        _SupplementCard(),
        SizedBox(height: 16),
        _FastRecord(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Readiness banner
// ---------------------------------------------------------------------------

class _ReadinessBanner extends StatelessWidget {
  const _ReadinessBanner();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: SurfaceCard(
        padding: const EdgeInsets.all(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Soft mint glow in the top-right corner.
            Positioned(
              right: -60,
              top: -60,
              child: IgnorePointer(
                child: Container(
                  width: 144,
                  height: 144,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.tertiaryFixed.withValues(alpha: 0.3),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Pill(
                        background: AppColors.primaryFixed,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const _PulsingDot(),
                            const SizedBox(width: 4),
                            Text('Optimal Zone',
                                style: AppText.labelSm.copyWith(color: AppColors.onPrimaryFixed)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Good morning, Sarah', style: AppText.headlineLgMobile),
                      const SizedBox(height: 2),
                      Text(
                        'High recovery detected. Prime day for cardio endurance.',
                        style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const _ReadinessBadge(score: 92),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
        ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 1.0, end: 0.5).animate(_c),
      child: const Dot(color: AppColors.primary),
    );
  }
}

class _ReadinessBadge extends StatelessWidget {
  const _ReadinessBadge({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CustomPaint(
              painter: RingPainter(
                progress: score / 100,
                color: AppColors.tertiary,
                trackColor: AppColors.surfaceDim,
                strokeWidth: 4.27,
                trackStrokeWidth: 4,
                inset: 2.78,
              ),
              child: Center(
                child: Text('$score',
                    style: AppText.headlineSm
                        .copyWith(color: AppColors.tertiary, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text('Readiness',
              style: AppText.labelSm
                  .copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Energy overview
// ---------------------------------------------------------------------------

class _EnergyOverviewCard extends StatelessWidget {
  const _EnergyOverviewCard();

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('METABOLIC BALANCE',
                        style: AppText.labelSm.copyWith(
                            color: AppColors.onSurfaceVariant, letterSpacing: 0.55)),
                    Text('Energy Overview', style: AppText.headlineSm),
                  ],
                ),
              ),
              Pill(
                background: AppColors.secondaryFixed,
                child: Text('Goal: 2,200 kcal',
                    style: AppText.labelSm.copyWith(color: AppColors.onSecondaryFixed)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 112,
                height: 112,
                child: CustomPaint(
                  painter: RingPainter(
                    progress: 0.645,
                    color: AppColors.primaryContainer,
                    trackColor: AppColors.surfaceContainerLow,
                    strokeWidth: 8.96,
                    inset: 11.2,
                  ),
                  foregroundPainter: RingPainter(
                    progress: 0.63,
                    color: AppColors.secondaryContainer,
                    trackColor: AppColors.surfaceContainerLow,
                    strokeWidth: 7.84,
                    inset: 24.64,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Net left',
                            style: AppText.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
                        Text('780',
                            style: AppText.headlineSm.copyWith(fontWeight: FontWeight.w800)),
                        Text('kcal',
                            style: AppText.labelSm.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Column(
                  children: [
                    _EnergyRow(
                        color: AppColors.primaryContainer, label: 'Consumed', value: '1,420'),
                    SizedBox(height: 10),
                    _EnergyRow(
                        color: AppColors.secondaryContainer, label: 'Active Burn', value: '680'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EnergyRow extends StatelessWidget {
  const _EnergyRow({required this.color, required this.label, required this.value});

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Dot(color: color, size: 10),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label,
                overflow: TextOverflow.ellipsis,
                style: AppText.bodySm.copyWith(fontWeight: FontWeight.w500)),
          ),
          Text.rich(TextSpan(
            text: value,
            style: AppText.headlineSm.copyWith(fontWeight: FontWeight.w700),
            children: [
              TextSpan(
                text: ' kcal',
                style: AppText.labelSm
                    .copyWith(fontWeight: FontWeight.w400, color: AppColors.onSurfaceVariant),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Metric grid
// ---------------------------------------------------------------------------

class _MetricFooter extends StatelessWidget {
  const _MetricFooter({required this.left, required this.right});

  final Widget left;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: AppText.labelSm.copyWith(color: AppColors.onSurfaceVariant),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Flexible(child: left), Flexible(child: right)],
        ),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  const _IconLabel({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 2),
        Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

class _StepsCard extends StatelessWidget {
  const _StepsCard();

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IconBubble(
                icon: Icons.directions_walk_rounded,
                background: AppColors.tertiaryFixed,
                foreground: AppColors.onTertiaryFixedVariant,
              ),
              Pill(
                background: AppColors.surfaceContainerHigh,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text('84%', style: AppText.labelSm.copyWith(fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('8,420', style: AppText.metricNumeral),
          Text('of 10,000 steps',
              style: AppText.bodySm
                  .copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.842,
              minHeight: 8,
              color: AppColors.tertiary,
              backgroundColor: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.all(Radius.circular(999)),
            ),
          ),
          const SizedBox(height: 10),
          const _MetricFooter(
            left: _IconLabel(icon: Icons.straighten_rounded, text: '6.1 km'),
            right: _IconLabel(icon: Icons.schedule_rounded, text: '48 min'),
          ),
        ],
      ),
    );
  }
}

class _BurnCard extends StatelessWidget {
  const _BurnCard();

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const IconBubble(
                icon: Icons.local_fire_department_rounded,
                background: AppColors.primaryFixed,
                foreground: AppColors.onPrimaryContainer,
              ),
              Flexible(
                child: Text('+12% vs avg',
                    overflow: TextOverflow.ellipsis,
                    style: AppText.labelSm.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('680', style: AppText.metricNumeral),
          Text('Burned today',
              style: AppText.bodySm
                  .copyWith(color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          SizedBox(
            height: 28,
            width: double.infinity,
            child: CustomPaint(painter: SparklinePainter(color: AppColors.primaryContainer)),
          ),
          const SizedBox(height: 4),
          const _MetricFooter(
            left: Text('HIIT: 420 kcal', overflow: TextOverflow.ellipsis),
            right: Text('Walk: 260 kcal', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hydration
// ---------------------------------------------------------------------------

class _HydrationCard extends StatefulWidget {
  const _HydrationCard();

  @override
  State<_HydrationCard> createState() => _HydrationCardState();
}

class _HydrationCardState extends State<_HydrationCard> {
  static const _goal = 2500;
  int _current = 1750;

  void _add(int ml) => setState(() => _current = (_current + ml).clamp(0, _goal));

  String _format(int n) => n.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+$)'),
        (m) => '${m[1]},',
      );

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        children: [
          Row(
            children: [
              const IconBubble(
                icon: Icons.water_drop_rounded,
                background: AppColors.secondaryFixed,
                foreground: AppColors.secondary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hydration', style: AppText.headlineSm),
                    Text('${_format(_current)} / ${_format(_goal)} ml',
                        style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              _WaterButton(
                label: '250ml',
                background: AppColors.secondaryFixed,
                foreground: AppColors.onSecondaryFixed,
                onTap: () => _add(250),
              ),
              const SizedBox(width: 6),
              _WaterButton(
                label: '500ml',
                background: AppColors.secondaryContainer,
                foreground: AppColors.onSecondaryContainer,
                onTap: () => _add(500),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 16,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(999),
            ),
            child: LayoutBuilder(
              builder: (context, c) => Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: c.maxWidth * (_current / _goal),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer,
                    borderRadius: BorderRadius.circular(999),
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

class _WaterButton extends StatelessWidget {
  const _WaterButton({
    required this.label,
    required this.background,
    required this.foreground,
    required this.onTap,
  });

  final String label;
  final Color background;
  final Color foreground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: onTap,
      child: Pill(
        background: background,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add_rounded, size: 14, color: foreground),
            const SizedBox(width: 2),
            Text(label, style: AppText.labelSm.copyWith(color: foreground)),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Supplement reminder
// ---------------------------------------------------------------------------

class _SupplementCard extends StatefulWidget {
  const _SupplementCard();

  @override
  State<_SupplementCard> createState() => _SupplementCardState();
}

class _SupplementCardState extends State<_SupplementCard> {
  bool _taken = false;

  @override
  Widget build(BuildContext context) {
    final fg = _taken ? AppColors.onTertiary : AppColors.onSurface;
    return SurfaceCard(
      child: Row(
        children: [
          const IconBubble(
            icon: Icons.medication_rounded,
            background: AppColors.surfaceContainerHigh,
            foreground: AppColors.onSurfaceVariant,
            size: 40,
            iconSize: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedOpacity(
                  opacity: _taken ? 0.6 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    'Vitamin D3 & Omega 3',
                    overflow: TextOverflow.ellipsis,
                    style: AppText.headlineSm.copyWith(
                      decoration: _taken ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.alarm_rounded, size: 13, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text('12:30 PM with Lunch',
                          overflow: TextOverflow.ellipsis,
                          style: AppText.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PressScale(
            onTap: () => setState(() => _taken = !_taken),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _taken ? AppColors.tertiary : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _taken ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    size: 16,
                    color: fg,
                  ),
                  const SizedBox(width: 6),
                  Text(_taken ? 'Taken' : 'Take', style: AppText.labelSm.copyWith(color: fg)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Fast record
// ---------------------------------------------------------------------------

class _FastRecord extends StatelessWidget {
  const _FastRecord();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FAST RECORD',
              style: AppText.labelSm
                  .copyWith(color: AppColors.onSurfaceVariant, letterSpacing: 0.55)),
          const SizedBox(height: 10),
          const Row(
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.restaurant_rounded,
                  label: 'Log Meal',
                  background: AppColors.primaryFixed,
                  foreground: AppColors.primary,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _QuickAction(
                  icon: Icons.local_drink_rounded,
                  label: 'Log Water',
                  background: AppColors.secondaryFixed,
                  foreground: AppColors.secondary,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _QuickAction(
                  icon: Icons.directions_run_rounded,
                  label: 'Workout',
                  background: AppColors.tertiaryFixed,
                  foreground: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return PressScale(
      onTap: () {},
      child: SurfaceCard(
        radius: 16,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            IconBubble(
              icon: icon,
              background: background,
              foreground: foreground,
              size: 36,
              iconSize: 20,
            ),
            const SizedBox(height: 6),
            Text(label, overflow: TextOverflow.ellipsis, style: AppText.labelMd),
          ],
        ),
      ),
    );
  }
}
