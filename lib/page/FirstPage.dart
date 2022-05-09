import 'package:flutter/material.dart';
import 'package:kwikcode_programmer_side/api/my_session.dart';
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
      body: const Center(
        child: Image(
          image: AssetImage('Assets/Other/KwikCodeLogo.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _timer() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
