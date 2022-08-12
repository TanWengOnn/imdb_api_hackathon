import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme_state.dart';


class ThemeCubit extends Cubit<ThemeState> {
  //set the default state of the dark theme to false
  ThemeCubit() : super(DarkTheme(false));

  void invertTheme()  {
    //to invert the state of the theme when the function is called
    emit(DarkTheme(!state.theme.isDark));
  }

}
