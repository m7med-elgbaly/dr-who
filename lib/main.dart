import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:heathly/mainPage.dart';
import 'package:heathly/model/appLoccale.dart';
import 'package:heathly/screens/doctorProfile.dart';
import 'package:heathly/screens/firebaseAuth.dart';
import 'package:heathly/screens/myAppointments.dart';
import 'package:heathly/screens/onboarding/onboarding.dart';
import 'package:heathly/screens/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? myShared;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          databaseURL: 'https://orbital-valor-335000-default-rtdb.firebaseio.com',
          messagingSenderId: '100936199114',
          apiKey: 'AIzaSyAyBU53wXQB0b3PxRqg1-1h1HpLVUNAmBI',
          appId: '1:100936199114:android:d6cabad1ef33e323fcbd33',
          projectId: 'orbital-valor-335000'),
      );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  myShared = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  MyApp({Key? key}) : super(key: key);

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    _getUser();
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) =>
            user == null ? const OnboardingScreen() : const MainPage(),
        '/login': (context) => const FireBaseAuth(),
        '/home': (context) => const MainPage(),
        '/profile': (context) => const UserProfile(),
        '/MyAppointments': (context) => const MyAppointments(),
        '/DoctorProfile': (context) => const DoctorProfile(
              doctor: '',
            ),
      },
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      title: "Doctor Who!",
      //home: FirebaseAuthDemo(),
      localizationsDelegates: const [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", ""),
        Locale("ar", ""),
      ],
      localeResolutionCallback: (currentLang, supportLang) {
        if (currentLang != null) {
          for (Locale locale in supportLang) {
            if (locale.languageCode == currentLang.languageCode) {
              myShared!.setString('lang', currentLang.languageCode);
              return currentLang;
            }
          }
        }
        return supportLang.first;
      },
    );
  }
}
