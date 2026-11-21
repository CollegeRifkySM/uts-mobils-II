import 'package:flutter/material.dart';

enum StatusMahasiswa {
  aktif(label: 'Aktif', color: Color(0xFF10B981)),
  cuti(label: 'Cuti', color: Color(0xFFF59E0B)),
  lulus(label: 'Lulus', color: Color(0xFF2541D9));

  const StatusMahasiswa({required this.label, required this.color});

  final String label;
  final Color color;

  StatusMahasiswa get next => switch (this) {
        StatusMahasiswa.aktif => StatusMahasiswa.cuti,
        StatusMahasiswa.cuti => StatusMahasiswa.lulus,
        StatusMahasiswa.lulus => StatusMahasiswa.aktif,
      };
}

class Skill {
  const Skill(this.nama, this.level, this.warna);

  final String nama;
  final int level;
  final Color warna;

  /// Two-character badge text, e.g. "Flutter" -> "Fl", "UI Design" -> "UI".
  String get monogram {
    final tanpaSpasi = nama.replaceAll(' ', '');
    return tanpaSpasi.length < 2 ? tanpaSpasi : tanpaSpasi.substring(0, 2);
  }

  double get persen => level / 100;
}

class Hobby {
  const Hobby(this.nama, this.icon, this.warna);

  final String nama;
  final IconData icon;
  final Color warna;
}

class Profile {
  const Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.hobi,
    required this.skill,
    required this.status,
  });

  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final List<Hobby> hobi;
  final List<Skill> skill;
  final StatusMahasiswa status;

  /// Initials from the first two words, e.g. "Rifky Saputra" -> "RS".
  String get inisial {
    final kata = nama.trim().split(RegExp(r'\s+')).where((k) => k.isNotEmpty);
    return kata.take(2).map((k) => k[0].toUpperCase()).join();
  }

  /// Rounded average skill level, 0 when there are no skills.
  int get rataRataSkill {
    if (skill.isEmpty) return 0;
    final total = skill.fold<int>(0, (sum, s) => sum + s.level);
    return (total / skill.length).round();
  }

  /// New list of skills sorted by level, highest first.
  List<Skill> skillTerurut() => [...skill]..sort((a, b) => b.level.compareTo(a.level));

  Profile copyWith({StatusMahasiswa? status}) => Profile(
        nama: nama,
        nim: nim,
        jurusan: jurusan,
        email: email,
        telepon: telepon,
        hobi: hobi,
        skill: skill,
        status: status ?? this.status,
      );
}
