import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milkshake/core/constants/colours.dart' as colour;
import 'package:milkshake/core/constants/strings.dart';
import 'package:milkshake/features/user/presentation/screens/sign_in_screen.dart';
import 'package:milkshake/features/user/presentation/screens/home_screen.dart';
import 'package:milkshake/features/user/presentation/screens/landing_screen.dart';
import 'package:milkshake/features/user/presentation/screens/sign_up_screen.dart';
import 'package:milkshake/injection.dart' as injection;

Future main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    injection.setup();
    runApp(const MilkshakeApp());
  } catch (error) {
    print('Error running Milkshake app: $error');
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

class MilkshakeApp extends StatelessWidget {
  const MilkshakeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Milkshake',
      debugShowCheckedModeBanner: false,
      theme: _milkshakeTheme,
      initialRoute: landingScreen,
      routes: {
        landingScreen: ((context) => const LandingScreen()),
        signInScreen: ((context) => const SignInScreen()),
        signUpScreen: ((context) => const SignUpScreen()),
        homeScreen: ((context) => const HomeScreen()),
      },
    );
  }

  ThemeData get _milkshakeTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(colour.primary),
        primaryColorLight: const Color(colour.primeLight),
        primaryColorDark: const Color(colour.primeDark),
        fontFamily: kanit,
      );
}
