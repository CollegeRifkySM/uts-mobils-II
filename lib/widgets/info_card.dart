import 'package:flutter/material.dart';

/// One row of an [InfoCard]: an icon, a small label and its value.
class InfoItem {
  const InfoItem({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;
}

/// Card with a list of [ListTile]s (icon box, label, value) separated by dividers.
class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.items});

  final List<InfoItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final rows = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      if (i > 0) {
        rows.add(
          Divider(
            height: 1,
            indent: 72,
            endIndent: 16,
            color: scheme.onSurface.withValues(alpha: 0.08),
          ),
        );
      }
      rows.add(_InfoTile(item: items[i]));
    }

    // The DecoratedBox only draws the soft tinted shadow; the Card draws the surface.
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(children: rows),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.item});

  final InfoItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(item.icon, size: 20, color: scheme.primary),
      ),
      title: Text(
        item.label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: scheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      subtitle: Text(
        item.value,
        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
