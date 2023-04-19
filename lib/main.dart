import 'package:flutter/material.dart';
import 'package:novel_flutter/screens/details_page.dart';
import 'package:novel_flutter/screens/home_page.dart';
import 'package:novel_flutter/screens/trending_page.dart';
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   runApp(const MyApp());
// }
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String title = 'Novel';
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
              //primaryColor: Colors.purple,
              ),
          //home: const MainPage(title: title),
          routes: {
            "/": (context) => HomePage(),
            "/trending": (context) => TrendingPage(),
          });
}
