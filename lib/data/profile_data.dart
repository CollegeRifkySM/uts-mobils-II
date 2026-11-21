import 'package:flutter/material.dart';

import '../models/profile.dart';

const Profile profilRifky = Profile(
  nama: 'Rifky Saputra Maylandra',
  nim: '24552011091',
  jurusan: 'Teknik Informatika',
  email: 'rifky.saputra@email.com',
  telepon: '+62 812-3456-7890',
  status: StatusMahasiswa.aktif,
  skill: [
    Skill('Flutter', 80, Color(0xFF2541D9)),
    Skill('Dart', 75, Color(0xFF0EA5E9)),
    Skill('Python', 70, Color(0xFFF59E0B)),
    Skill('UI Design', 65, Color(0xFFEC4899)),
    Skill('Git', 70, Color(0xFFEF4444)),
    Skill('Firebase', 60, Color(0xFFF97316)),
  ],
  hobi: [
    Hobby('Nonton film', Icons.movie_outlined, Color(0xFFEC4899)),
    Hobby('Main game', Icons.sports_esports_outlined, Color(0xFF8B5CF6)),
    Hobby('Vibecoding', Icons.code, Color(0xFF2541D9)),
    Hobby('Musik', Icons.music_note_outlined, Color(0xFF10B981)),
    Hobby('Membaca', Icons.menu_book_outlined, Color(0xFFF59E0B)),
  ],
);
