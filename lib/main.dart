import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/profile_cubit.dart';
import 'data/profile_data.dart';
import 'pages/profil_page.dart';
import 'theme/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Bonus: the light/dark mode is plain widget state, switched with setState().
  ThemeMode _mode = ThemeMode.light;

  bool get _isDark => _mode == ThemeMode.dark;

  void _toggleTheme() {
    setState(() => _mode = _isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(profilRifky),
      child: MaterialApp(
        title: 'Profil Mahasiswa',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _mode,
        home: ProfilPage(isDark: _isDark, onToggleTheme: _toggleTheme),
      ),
    );
  }
}
