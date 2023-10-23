import 'package:get/get.dart';
import '../views/common_widgets/theme_storage.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the theme mode from shared preferences.
    getThemeModeFromStorage();
  }

  // Save the theme mode preference in shared preferences and update the controller.
  Future<void> saveThemeMode(bool isDarkMode) async {
    ThemeStorage().saveThemeMode(isDarkMode);
    this.isDarkMode.value = isDarkMode;
  }

  // Retrieve the theme mode preference from shared preferences.
  Future<void> getThemeModeFromStorage() async {
    bool isDarkMode = await ThemeStorage().getThemeMode();
    this.isDarkMode.value = isDarkMode;
  }

  // Toggle the theme mode.
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // Save the updated theme mode.
    saveThemeMode(isDarkMode.value);
  }
}
