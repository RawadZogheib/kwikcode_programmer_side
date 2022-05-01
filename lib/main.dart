import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/page/FirstPage.dart';
import 'package:kwikcode_programmer_side/page/HomePage.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1280, 720);
    const minSize = Size(1024, 600);
    win.minSize = minSize;
    // win.maxSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "KwikCode";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'MyWallet',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: FirstPage(),
          initialRoute: '/FirstPage',
          routes: {
            '/FirstPage': (context) => const FirstPage(),
            '/HomePage': (context) => const HomePage(),
          });
  }
}
