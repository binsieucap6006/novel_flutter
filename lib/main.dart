import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter/constants.dart';
import 'package:novel_flutter/routes/app_pages.dart';
import 'package:novel_flutter/screens/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA5NgoI83fRIy5aLgibCaP2tDBLXzBZCec',
      appId: "Novel Hovel",
      messagingSenderId: '445637014017',
      projectId: 'novelhovel-8a04e',
    ),
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  //runApp(const MyApp());
  runApp(ProviderScope(child: MyApp(app: app)));
}

class MyApp extends StatefulWidget {
  final FirebaseApp app;
  const MyApp({super.key, required this.app});
  static const String title = 'Novel Hovel';
  //const MyApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.transparent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      // routes: {
      //   "/": (context) => const HomePage(),
      // },
    );
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Novel Hovel",
      onGenerateRoute: _appRouter.onGenerateRoute,
      home: const WidgetTree(),
    );
  }
}
