import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit() : super(false);

  bool _isDark = false;
  bool get isDark => _isDark;

  Future<void> init() async {
    _isDark = true;
    emit(_isDark);
  }
}
