import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentapp_firebase/view/login_page.dart';
import 'package:studentapp_firebase/view/login/login_screen.dart';
import 'package:studentapp_firebase/view/user_login/user_login.dart';
import 'package:studentapp_firebase/view/welcome_page/welcome_page.dart';
import 'package:studentapp_firebase/view_model/auth/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((_) => AuthenticationService()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.

          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => LoginScreen(),
          "Create": (context) => Createpage(),
          "SignIn": (context) => const WelcomePage(),
          "Signout": (context) => LoginScreen(),
          "welcome": (context) => const WelcomePage(),
        },
      ),
    );
  }
}
