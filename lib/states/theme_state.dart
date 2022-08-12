abstract class ThemeState {
  final IsDark theme;

  ThemeState(this.theme);
}

// // Dark
class DarkTheme extends ThemeState {
  DarkTheme(bool isDark) : super(IsDark(isDark));
}

//model 
class IsDark {
  final bool isDark;

  IsDark(this.isDark);
}
