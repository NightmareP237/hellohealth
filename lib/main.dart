import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hellohealth/screens/home/SplashScreen/Sp1.dart';
import 'package:hellohealth/screens/home/home_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hellohealth/screens/home/statut.dart';
import 'package:provider/provider.dart';
import 'screens/home/SplashScreen/essai.dart';
import 'loop-page.dart';
import 'models/auth_provider.dart';
import 'models/userpreference.dart';
import 'screens/home/login/login_page.dart';

main() async {
  // These two lines
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  

  FlutterNativeSplash.remove();
  
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
FirebaseAuth auth = FirebaseAuth.instance;

  
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (BuildContext context) => AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
          builder: (context, auth, _) => MaterialApp(
            color: Colors.orange,
                debugShowCheckedModeBanner: false,
                //theme: Theme.of(context),
                title: 'HelloHealth',
                home:
                    Statut(),
                routes: {
                  LoginPage.routeName: (ctx) => LoginPage(),
                },
              )),
    );
  }
}
