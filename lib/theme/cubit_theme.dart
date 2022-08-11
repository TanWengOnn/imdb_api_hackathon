import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_state_theme.dart';


class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(DarkTheme(false));

  void invertTheme()  {
    emit(DarkTheme(!state.theme.isDark));
  }

}
