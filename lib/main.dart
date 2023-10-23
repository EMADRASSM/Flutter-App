import 'package:emart_app/controller/theme_controller.dart';
import 'package:emart_app/views/common_widgets/theme_storage.dart';
import 'package:emart_app/views/splah_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ThemeController themeController = Get.put(ThemeController());
  final ThemeStorage themeStorage = ThemeStorage();

  // Retrieve the theme mode preference and initialize the controller.
  bool isDarkMode = await themeStorage.getThemeMode();
  themeController.isDarkMode.value = isDarkMode;

  // The entry point for accessing Firebase.
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCpdB9B2sNGSPOeyF7oVgacyYLjw_2Hy14",
          appId: "",
          messagingSenderId: "",
          projectId: "emart-bb775"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // we are using getX so we have to change this material app to getmetrial app .
    return Obx(() {
      final isDarkMode = Get.find<ThemeController>().isDarkMode.value;

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appname,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            // to set app bar icons color
            iconTheme: IconThemeData(color: darkFontGrey),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            // color: darkFontGrey,
          ),
          fontFamily: regular,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: redColor,
          ),
          splashColor: redColor,
        ),

        // theme: ThemeData.light().copyWith(
        //   scaffoldBackgroundColor: Colors.transparent,
        //   appBarTheme: const AppBarTheme(
        //     // to set app bar icons color
        //     iconTheme: IconThemeData(color: darkFontGrey),
        //     elevation: 0.0,
        //     backgroundColor: Colors.transparent,
        //   ),
        // ),

        darkTheme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(
                bodyColor: whiteColor, // Set the text color to white
              ),
          splashColor:
              dark_lightGrey, // Set the splash color for the dark theme
        ),

        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: const SplashScreen(),
      );
    });
  }
}
