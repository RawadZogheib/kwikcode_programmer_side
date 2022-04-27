import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/globals/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: globals.darkBlue1,
      body: Container(
        alignment: Alignment.center,
        child: Wrap(
          children: [
            Icon(
              Icons.flutter_dash,
              color: globals.white1,
            ),
          ],
        ),
        // const Image(
        //   image: AssetImage('Assets/HomePage/logo.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }

  _timer() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushNamedAndRemoveUntil(context, '/HomePage', (route) => false);
    } catch (e) {
      print(e);
    }
  }
}
