import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/profile.dart';

class ProfileCubit extends Cubit<Profile> {
  ProfileCubit(super.initial);

  void ubahStatus(StatusMahasiswa status) => emit(state.copyWith(status: status));

  void statusBerikutnya() => emit(state.copyWith(status: state.status.next));
}
