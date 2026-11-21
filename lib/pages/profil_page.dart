import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';
import '../models/profile.dart';
import '../widgets/action_buttons.dart';
import '../widgets/hobby_item.dart';
import '../widgets/info_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_item.dart';

/// The single screen of the app. Data comes from [ProfileCubit]; the
/// light/dark switch is owned by the parent (see main.dart).
class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key, required this.isDark, required this.onToggleTheme});

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, Profile>(
        builder: (context, profile) => Center(
          // Keep the layout phone-sized and centred on tablets / desktop.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                ProfileHeader(
                  status: profile.status,
                  isDark: widget.isDark,
                  onToggleTheme: widget.onToggleTheme,
                ),
                const SizedBox(height: 8),
                _identity(context, profile),
                const SizedBox(height: 24),
                ActionButtons(email: profile.email, nim: profile.nim),
                const SizedBox(height: 32),
                const SectionTitle('Kontak'),
                _kontak(profile),
                const SizedBox(height: 32),
                SectionTitle('Skill', trailing: 'Rata-rata ${profile.rataRataSkill}%'),
                _skillGrid(profile),
                const SizedBox(height: 32),
                const SectionTitle('Hobi', trailing: 'Geser untuk lihat semua'),
                _hobiList(profile),
                _footer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Name, major and the NIM chip, all centred.
  Widget _identity(BuildContext context, Profile profile) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            profile.nama,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 4),
          Text(
            profile.jurusan,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'NIM ${profile.nim}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: scheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kontak(Profile profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InfoCard(
        items: [
          InfoItem(icon: Icons.mail_outline, label: 'Email', value: profile.email),
          InfoItem(icon: Icons.phone_outlined, label: 'Telepon', value: profile.telepon),
          InfoItem(icon: Icons.school_outlined, label: 'Jurusan', value: profile.jurusan),
        ],
      ),
    );
  }

  /// 2 columns on phones; more columns appear automatically on wider screens.
  Widget _skillGrid(Profile profile) {
    final skills = profile.skillTerurut();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 96,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: skills.length,
        itemBuilder: (context, i) => SkillItem(skills[i]),
      ),
    );
  }

  Widget _hobiList(Profile profile) {
    return SizedBox(
      height: 148,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // 8 + 120 + 20 = 148: the extra room keeps the card shadows from being clipped.
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
        itemCount: profile.hobi.length,
        itemBuilder: (context, i) => Padding(
          padding: EdgeInsets.only(right: i == profile.hobi.length - 1 ? 0 : 12),
          child: HobbyItem(profile.hobi[i]),
        ),
      ),
    );
  }

  Widget _footer(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Text(
        'By Rifky Saputra Maylandra',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
