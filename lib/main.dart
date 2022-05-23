import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
  ]);
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News app',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 17, 17, 17),
          elevation: 15,
        ),
        primaryColor: Colors.black26,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(title: 'Naujienos!'),
    );
  }
}
