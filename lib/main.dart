import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hellohealth/screens/home/home_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:provider/provider.dart';
import 'SplashScreen/essai.dart';
import 'models/auth_provider.dart';
import 'models/userpreference.dart';
import 'screens/auth/login/login_page.dart';

main() async {
  // These two lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  WidgetsFlutterBinding.ensureInitialized();
  await UserPreference.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final user = UserPreference.getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
          builder: (context, auth, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                //theme: Theme.of(context),
                title: 'HelloHealth',
                home:
                    auth.isAuthenticated == true ? const HomePage() : Splash(),
                routes: {
                  LoginPage.routeName: (ctx) => LoginPage(),
                },
              )),
    );
  }
}
