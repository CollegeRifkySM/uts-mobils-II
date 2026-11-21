import 'package:flutter/material.dart';

/// Section heading ("Kontak", "Skill", "Hobi") with an optional caption on the right.
///
/// It carries its own 24 px side padding and 12 px bottom padding so the
/// content below it can sit directly underneath.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final caption = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.textTheme.titleMedium),
          if (trailing != null) Text(trailing!, style: caption),
        ],
      ),
    );
  }
}
