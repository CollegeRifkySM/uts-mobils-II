import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Two side-by-side buttons: "Kirim email" (opens the mail app) and
/// "Salin NIM" (copies the NIM to the clipboard).
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key, required this.email, required this.nim});

  final String email;
  final String nim;

  Future<void> _kirimEmail(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    var berhasil = false;
    try {
      berhasil = await launchUrl(Uri(scheme: 'mailto', path: email));
    } catch (_) {
      berhasil = false; // no mail app / platform not supported
    }
    if (!berhasil) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Tidak bisa membuka aplikasi email')),
      );
    }
  }

  Future<void> _salinNim(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: nim));
    messenger.showSnackBar(const SnackBar(content: Text('NIM disalin')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
    final label = theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () => _kirimEmail(context),
              icon: const Icon(Icons.mail_outline, size: 20),
              label: const Text('Kirim email'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: shape,
                textStyle: label,
                elevation: 3,
                shadowColor: scheme.primary.withValues(alpha: 0.4),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _salinNim(context),
              icon: const Icon(Icons.copy_outlined, size: 20),
              label: const Text('Salin NIM'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: shape,
                textStyle: label,
                foregroundColor: scheme.primary,
                backgroundColor: scheme.surface,
                side: BorderSide(color: scheme.onSurface.withValues(alpha: 0.12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
