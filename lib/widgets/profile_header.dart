import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';
import '../models/profile.dart';
import '../theme/app_theme.dart';

/// Always-white colour for content drawn on the blue header gradient.
const Color _onHeader = Colors.white;

/// Top part of the profile page, built with a [Stack]:
/// gradient header (232 high) -> decorations -> title row + theme toggle,
/// then the avatar overlapping the header edge and the tappable status badge.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.status,
    required this.isDark,
    required this.onToggleTheme,
  });

  final StatusMahasiswa status;
  final bool isDark;
  final VoidCallback onToggleTheme;

  static const double _headerHeight = 232;
  static const double _avatarTop = 176;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Keep the title clear of the status bar (the mockup uses 48 from the top).
    final inset = MediaQuery.paddingOf(context).top;
    final topRowY = (inset < 24 ? 24.0 : inset) + 24;

    return SizedBox(
      height: 300, // header + the part of the avatar/badge that hangs below it
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Gradient background with the faint decorations, clipped to the rounded bottom.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _headerHeight,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark ? AppColors.headerDark : AppColors.headerLight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 16,
                    top: 64,
                    child: Text(
                      '</>',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 120,
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: _onHeader.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -28,
                    bottom: -46,
                    child: Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _onHeader.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Title row with the light/dark toggle.
          Positioned(
            top: topRowY,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profil Saya',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    color: _onHeader,
                  ),
                ),
                IconButton(
                  onPressed: onToggleTheme,
                  tooltip: isDark ? 'Mode terang' : 'Mode gelap',
                  icon: Icon(
                    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                  ),
                  style: IconButton.styleFrom(
                    fixedSize: const Size(40, 40),
                    foregroundColor: _onHeader,
                    backgroundColor: _onHeader.withValues(alpha: 0.18),
                  ),
                ),
              ],
            ),
          ),

          // 3. Avatar, centred and overlapping the bottom edge of the header.
          const Positioned(
            top: _avatarTop,
            left: 0,
            right: 0,
            child: Center(child: _Avatar()),
          ),

          // 4. Status badge at the avatar's bottom-right. It sits in the full-width
          //    Stack (shifted with Transform) so taps outside the avatar box still land.
          Positioned(
            top: 260,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.translate(
                offset: const Offset(50, 0),
                child: _StatusBadge(
                  status: status,
                  onTap: () => context.read<ProfileCubit>().statusBerikutnya(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 112 px avatar: outer ring (4 px, page background colour) + soft shadow.
class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 56,
        backgroundColor: theme.scaffoldBackgroundColor, // the ring
        child: CircleAvatar(
          radius: 52,
          backgroundColor: Color.alphaBlend(
            scheme.primary.withValues(alpha: 0.12),
            scheme.surface,
          ),
          // Placeholder photo. To use your real photo, drop it in assets/images/
          // and change the path below (e.g. 'assets/images/foto.jpg').
          child: ClipOval(
            child: Image.asset(
              'assets/images/foto_placeholder.png',
              width: 104,
              height: 104,
              fit: BoxFit.cover,
              // Falls back to an icon if the image can't be loaded.
              errorBuilder: (_, _, _) =>
                  Icon(Icons.person_outline, size: 48, color: scheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pill with a coloured dot and the student status; tapping it cycles the status.
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.onTap});

  final StatusMahasiswa status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status.color,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  status.label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
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
